# Copyright (c) 2009 by David Golden. All rights reserved.
# Licensed under Apache License, Version 2.0 (the "License").
# You may not use this file except in compliance with the License.
# A copy of the License was distributed with this file or you may obtain a 
# copy of the License from http://www.apache.org/licenses/LICENSE-2.0

use strict;
use lib 'inc';
eval "require Pod::WikiDoc";
my $class = $@ ? "Module::Build" : "Module::Build::WikiDoc";
eval "require $class";
my $build = $class->new( 
  module_name => 'ylib',
  dist_author => 'David Golden <dagolden@cpan.org>',
  license => 'apache',
  create_readme => 1,
  create_makefile_pl  => 'traditional',
  requires => {
    'perl' => '5.006',
    'File::HomeDir' => 0.86,
    'Path::Class' => 0.16,
  },
  build_requires => {
    'File::Basename' => 0,
    'File::Copy' => 2.11, # 2.02 in perl 5.00504; 2.03 in perl 5.006002; 2.09 in perl 5.008008; 
    'File::pushd' => 1.00,
    'Test::More' => 0.62, # 0.47 in perl 5.006002; 0.62 in perl 5.008008; 
  },
  meta_add            => { 
    no_index => { 
      directory => [ qw/ examples inc t xt /],
    },
    resources => {
      repository => "http://github.com/dagolden/ylib/", 
      bugtracker => "http://rt.cpan.org/NoAuth/Bugs.html?Dist=ylib",
    },
  },
);
$build->create_build_script;

