use 5.010;
use strict;
use warnings;

package DB::Pluggable::Plugin::DataPrinter;
BEGIN {
  $DB::Pluggable::Plugin::DataPrinter::VERSION = '1.111750';
}

# ABSTRACT: Debugger plugin to use Data::Printer
use Role::Basic;
use Data::Printer; # to make it a requirement
with qw(DB::Pluggable::Role::Initializer);

sub initialize {
    no warnings 'once';
    $DB::alias{p} = 's/^/use Data::Printer; /; eval $cmd';
}
1;


__END__
=pod

=for test_synopsis 1;
__END__

=head1 NAME

DB::Pluggable::Plugin::DataPrinter - Debugger plugin to use Data::Printer

=head1 VERSION

version 1.111750

=head1 SYNOPSIS

    $ cat ~/.perldb

    use DB::Pluggable;
    DB::Pluggable->run_with_config(\<<EOINI)
    [BreakOnTestNumber]
    EOINI

    $ perl -d foo.pl

    Loading DB routines from perl5db.pl version 1.28
    Editor support available.

    Enter h or `h h' for help, or `man perldebug' for more help.

    1..9
    ...
      DB<1> c
      ...
      DB<2> p %foo

=head1 DESCRIPTION

This debugger plugin exposes L<Data::Printer>'s C<p> command to the
debugger. Use the C<~/.dataprinter> file to control the output - see
L<Data::Printer> for details.

=head1 METHODS

=head2 initialize

Defines a debugger alias for the C<p> command.

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

