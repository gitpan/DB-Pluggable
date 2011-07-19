use strict;
use warnings;
use ExtUtils::MakeMaker 6.58;
WriteMakefile(
    ABSTRACT           => 'Add plugin support for the Perl debugger',
    AUTHOR             => 'Marcel Gruenauer <marcel@cpan.org>',
    CONFIGURE_REQUIRES => { 'ExtUtils::MakeMaker' => '6.30' },
    DISTNAME           => 'DB-Pluggable',
    LICENSE            => 'perl',
    NAME               => 'DB::Pluggable',
    PREREQ_PM          => {
        'Brickyard'               => '1.111750',
        'Brickyard::Accessor'     => '0',
        'Brickyard::Role::Plugin' => '0',
        'Data::Printer'           => '0',
        'Hook::LexWrap'           => '0',
        'Role::Basic'             => '0',
        'Test::Builder'           => '0'
    },
    VERSION => '1.112000',
    test    => { TESTS => 't/*.t' }
);
