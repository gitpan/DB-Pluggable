use 5.008;
use strict;
use warnings;

package DB::Pluggable::Plugin;
BEGIN {
  $DB::Pluggable::Plugin::VERSION = '1.101051';
}
# ABSTRACT: Base classes for DB::Pluggable plugins
use parent 'Hook::Modular::Plugin';

sub make_command {
    my ($self, $cmd_name, $code) = @_;
    no strict 'refs';
    my $sub_name = "DB::cmd_$cmd_name";
    *{$sub_name} = $code;
    $DB::alias{$cmd_name} = "/./; &$sub_name;";
}
1;


__END__
=pod

=head1 NAME

DB::Pluggable::Plugin - Base classes for DB::Pluggable plugins

=head1 VERSION

version 1.101051

=head1 SYNOPSIS

    package DB::Pluggable::MyCommand;
    use strict;
    use warnings;
    use base 'DB::Pluggable::Plugin';

    sub register {
        my ($self, $context) = @_;
        $self->make_command(
            Th => sub {
                # ...
            }
        );
    }

=head1 DESCRIPTION

This is a base class for plugins for L<DB::Pluggable>. Plugins should inherit
from it, so if we later add some basic functionality to this class, we don't
have to rewrite the plugins.

=head1 METHODS

=head2 make_command

Takes a command name string and a code reference and makes a new debugger
command. It abuses the debugger's alias mechanism to do so.

=head1 INSTALLATION

See perlmodinstall for information and options on installing Perl modules.

=head1 BUGS AND LIMITATIONS

No bugs have been reported.

Please report any bugs or feature requests through the web interface at
L<http://rt.cpan.org/Public/Dist/Display.html?Name=DB-Pluggable>.

=head1 AVAILABILITY

The latest version of this module is available from the Comprehensive Perl
Archive Network (CPAN). Visit L<http://www.perl.com/CPAN/> to find a CPAN
site near you, or see
L<http://search.cpan.org/dist/DB-Pluggable/>.

The development version lives at
L<http://github.com/hanekomu/DB-Pluggable/>.
Instead of sending patches, please fork this project using the standard git
and github infrastructure.

=head1 AUTHOR

  Marcel Gruenauer <marcel@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2008 by Marcel Gruenauer.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

