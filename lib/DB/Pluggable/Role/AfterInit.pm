use 5.010;
use strict;
use warnings;

package DB::Pluggable::Role::AfterInit;
BEGIN {
  $DB::Pluggable::Role::AfterInit::VERSION = '1.111750';
}

# ABSTRACT: Do something in the debugger's afterinit() function
use Role::Basic;
with qw(Brickyard::Role::Plugin);
requires qw(afterinit);
1;


__END__
=pod

=for stopwords afterinit

=head1 NAME

DB::Pluggable::Role::AfterInit - Do something in the debugger's afterinit() function

=head1 VERSION

version 1.111750

=head1 IMPLEMENTING

The C<AfterInit> role indicates that a plugin wants to do something
during the debugger's C<afterinit()> function. The plugin must provide
the C<afterinit()> method.

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

