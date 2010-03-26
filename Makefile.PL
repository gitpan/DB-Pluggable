
use strict;
use warnings;

 BEGIN { require 5.008; } 

use ExtUtils::MakeMaker 6.11;



my %WriteMakefileArgs = (
                       'test' => {
                                   'TESTS' => 't/*.t'
                                 },
                       'NAME' => 'DB::Pluggable',
                       'DISTNAME' => 'DB-Pluggable',
                       'CONFIGURE_REQUIRES' => {
                                                 'ExtUtils::MakeMaker' => '6.11'
                                               },
                       'AUTHOR' => 'Marcel Gruenauer <marcel@cpan.org>',
                       'BUILD_REQUIRES' => {},
                       'ABSTRACT' => 'Add plugin support for the Perl debugger',
                       'EXE_FILES' => [],
                       'VERSION' => '1.100850',
                       'PREREQ_PM' => {
                                        'Scalar::Util' => '0',
                                        'English' => '0',
                                        'parent' => '0',
                                        'YAML' => '0',
                                        'Data::Dumper' => '0',
                                        'constant' => '0',
                                        'Exporter' => '0',
                                        'Hook::LexWrap' => '0',
                                        'Carp' => '0',
                                        'Test::More' => '0.88',
                                        'Test::Differences' => '0',
                                        'File::Find' => '0',
                                        'Hook::Modular' => '0',
                                        'File::Temp' => '0',
                                        'Hook::Modular::Plugin' => '0'
                                      },
                       'LICENSE' => 'perl'
                     );


delete $WriteMakefileArgs{LICENSE}
  unless eval { ExtUtils::MakeMaker->VERSION(6.31) };

WriteMakefile(%WriteMakefileArgs);



