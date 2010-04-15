use 5.008;
use strict;
use warnings;

package DB::Pluggable::Constants;
BEGIN {
  $DB::Pluggable::Constants::VERSION = '1.101051';
}
# ABSTRACT: Constants for debugger plugin hook methods
use Exporter qw(import);
our %EXPORT_TAGS = (util => [qw(HANDLED DECLINED)],);
our @EXPORT_OK = @{ $EXPORT_TAGS{all} = [ map { @$_ } values %EXPORT_TAGS ] };
use constant HANDLED  => '200';
use constant DECLINED => '500';
1;


__END__
=pod

=head1 NAME

DB::Pluggable::Constants - Constants for debugger plugin hook methods

=head1 VERSION

version 1.101051

=head1 SYNOPSIS

    package DB::Pluggable::MyUsefulCommand;

    use DB::Pluggable::Constants ':all';

    sub do_it {
        my ($self, $context, $args) = @_;
        # ...
        if ("some condition") {
            # ...
            return HANDLED;
        } else {
            return DECLINED;
        }
    }

=head1 DESCRIPTION

This module defines constants that should be used by hooks as return values.
The following constants are defined:

=over 4

=item HANDLED

This constant should be returned by a command-related hook method to indicate
that it has handled the debugger command.

=item DECLINED

This constant should be returned by a command-related hook method to indicate
that it has not handled the debugger command.

=back

L<DB::Pluggable>'s plugin-enabled replacements for the debugger commands use
these constants to determine whether a command has been handled by one of the
plugins or whether it should be passed on to the default command handler
defined in C<perl5db.pl>.

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
