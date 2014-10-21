use 5.010;
use strict;
use warnings;

package DB::Pluggable;
BEGIN {
  $DB::Pluggable::VERSION = '1.111750';
}

# ABSTRACT: Add plugin support for the Perl debugger
use Brickyard::Accessor new => 1, rw => [qw(brickyard)];
use Brickyard 1.111750;

sub run_with_config {
    my $file = $_[1];
    __PACKAGE__->new->init_from_config($file)->run;
}

sub plugins_with {
    my ($self, $role) = @_;
    $self->brickyard->plugins_with($role);
}

sub init_from_config {
    my $self = shift;
    $self->brickyard(Brickyard->new(base_package => 'DB::Pluggable'));
    $self->brickyard->init_from_config(@_);
    $self;
}

sub enable_watchfunction {
    my $self = shift;
    no warnings 'once';
    $DB::trace |= 4;    # Enable watchfunction
}

sub run {
    my $self = shift;
    $DB::Pluggable::HANDLER = $self;
    $_->initialize for $self->plugins_with(-Initializer);
}
1;

# switch package so as to get the desired stack trace
package                 # hide from PAUSE indexer
  DB;

sub watchfunction {
    return unless defined $DB::Pluggable::HANDLER;
    my $depth = 1;
    while (1) {
        my ($package, $file, $line, $sub) = caller $depth;
        last unless defined $package;
        return if $sub =~ /::DESTROY$/;
        $depth++;
    }
    $_->watchfunction for $DB::Pluggable::HANDLER->plugins_with(-WatchFunction);
}

sub afterinit {
    return unless defined $DB::Pluggable::HANDLER;
    $_->afterinit for $DB::Pluggable::HANDLER->plugins_with(-AfterInit);
}
no warnings 'redefine';
my $DB_eval = \&DB::eval;
*eval = sub {
    my @result;
    for my $plugin ($DB::Pluggable::HANDLER->plugins_with(-Eval)) {
        push @result => $plugin->eval;
    }
    &$DB_eval;    # XXX Why doesn't this work if called from the plugin?
    $_->() for grep { ref eq 'CODE' } @result;
};
1;


__END__
=pod

=for test_synopsis 1;
__END__

=head1 NAME

DB::Pluggable - Add plugin support for the Perl debugger

=head1 VERSION

version 1.111750

=head1 SYNOPSIS

    $ cat ~/.perldb
    use DB::Pluggable;
    DB::Pluggable->run_with_config(\<<EOINI)
    [BreakOnTestNumber]

    [TypeAhead]
    type = {l
    type = c
    ifenv = DBTYPEAHEAD

    [StackTraceAsHTML]
    [DataPrinter]
    EOINI

Then:

    $ perl -d foo.pl

=head1 DESCRIPTION

This class adds plugin support to the Perl debugger. It is based on
L<Brickyard>, so see its documentation for details.

You need to have a C<~/.perldb> file (see L<perldebug> for details)
that invokes the plugin mechanism.

Plugins should live in the C<DB::Pluggable::Plugin::> namespace, like
L<DB::Pluggable::Plugin::BreakOnTestNumber> does.

=head1 METHODS

=head2 enable_watchfunction

Tells the debugger to call C<DB::watchfunction()>, which in turn
calls the C<watchfunction()> method of all plugins that consume the
C<-WatchFunction> role.

=head2 run_with_config

Convenience class method to create, initialize and run the plugin
system with the given configuration file or scalar reference.

=head2 plugins_with

Like the method with the same name in L<Brickyard>.

=head2 init_from_config

Like the method with the same name in L<Brickyard>.

=head2 run

This method just calls the C<initialize()> method of all plugins that
consume the C<-Initializer> role.

=head1 Plugin Phases

This class is very much in beta, so it's more like a proof of concept.
Therefore, not all roles - which more or less correspond to plugin
phases - imaginable have been added, only the ones to make this demo
work. If you want more roles or if the current roles don't work for
you, let me know.

The following roles exist:

=over 4

=item C<-Initializer>

See L<DB::Pluggable::Role::Initializer>.

=item C<-WatchFunction>

See L<DB::Pluggable::Role::WatchFunction>.

=item C<-CmdBHandler>

See L<DB::Pluggable::Role::CmdBHandler>. The C<cmd_b()> method
implemented by a plugin consuming this role will get the same
arguments as the C<DB::cmd_b()> function.

=item C<-AfterInit>

See L<DB::Pluggable::Role::AfterInit>.

=item C<-Eval>

See L<DB::Pluggable::Role::Eval>. The debugger's C<eval()> function is
overridden so we can make it pluggable. Each plugin will get a chance
to inspect the command line, which is the last line in C<$DB::evalarg>
and act on it. The plugin can return a code reference which will be
executed after the original C<DB::eval()> function has finished. Using
the code reference you can undo any temporary changes you might have
introduced to make your command work.

=back

=head1 INSTALLATION

See perlmodinstall for information and options on installing Perl modules.

=head1 BUGS AND LIMITATIONS

No bugs have been reported.

Please report any bugs or feature requests through the web interface at
L<http://rt.cpan.org/Public/Dist/Display.html?Name=DB-Pluggable>.

=head1 AVAILABILITY

The latest version of this module is available from the Comprehensive Perl
Archive Network (CPAN). Visit L<http://www.perl.com/CPAN/> to find a CPAN
site near you, or see L<http://search.cpan.org/dist/DB-Pluggable/>.

The development version lives at L<http://github.com/hanekomu/DB-Pluggable>
and may be cloned from L<git://github.com/hanekomu/DB-Pluggable.git>.
Instead of sending patches, please fork this project using the standard
git and github infrastructure.

=head1 AUTHOR

Marcel Gruenauer <marcel@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2008 by Marcel Gruenauer.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

