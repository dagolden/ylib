# Copyright (c) 2009 by David Golden. All rights reserved.
# Licensed under Apache License, Version 2.0 (the "License").
# You may not use this file except in compliance with the License.
# A copy of the License was distributed with this file or you may obtain a 
# copy of the License from http://www.apache.org/licenses/LICENSE-2.0

package ylib;
use strict;
use warnings;
use File::HomeDir 0.86 ();
use Path::Class;

require lib;

our $VERSION = '0.002';
$VERSION = eval $VERSION; ## no critic

my $name = '.mylib';

sub import {
  my $class = shift;
  my @configs = map { file($_, $name) } ( File::HomeDir->my_home(), '.' );
  for my $f (@configs) {
    next unless  -r $f;
    my $fh = $f->openr;
    while ( my $path = <$fh> ) {
      chomp $path;
      my $dir = dir($path);
      if ( -d $dir ) {
        lib->import( "$dir" );
      }
      else {
        warn "lib '$dir' was not found. skipping it\n";
      }
    }
  }
  return 1;
}

1;

__END__

=begin wikidoc

= NAME

ylib - Add paths to @INC from a config file

= VERSION

This documentation describes version %%VERSION%%.

= SYNOPSIS

  # in .mylib file
  /home/david/some/library/path
  
  # from the command line
  $ perl -Mylib -E 'say for @INC'
  /home/david/some/library/path
  ...

= DESCRIPTION

The ylib module adds paths to {@INC} from a configuration file named {.mylib}
in which each line represents a library path.  The {.mylib} file can be either
in the current directory and/or in the user's home directory.  It is equivalent
to calling {'use lib'} on each path.

Note: {ylib} will issue a warning if a path in {.mylib} can't be found.

= USAGE

Occasionally, it's useful to customize {@INC} on a per-directory basis without
changing the global {PERL5LIB} environment variable.  For example, when
developing or testing code that requires uninstalled code in an adjancent
directory, one could create a {.mylib} file that adds the necessary path.

For example, consider this directory tree with two Perl distributions, Foo-Bar
and Baz-Bam:

  ~/projects/
      Foo-Bar/
      Baz-Bam/

The code in Foo-Bar depends on code in Baz-Bam.  So in Foo-Bar, create a
{.mylib} file with the appropriate path:

  $ cd Foo-Bar
  $ echo '../Baz-Bam/lib' > .mylib
  $ perl -Mylib Build.PL
  $ Build && Build test

That's easier and shorter than using {PERL5LIB} on the command line, and it
scales better as the number of libraries increases.

In the example above, the {Build} script preserve {@INC} including the effect
of {-Mylib} when it was created.  This is not the case with {Makefile.PL} or
{prove}, in which case, {PERL5OPT} might be an alternative approach for using
{-Mylib}:

  $ export PERL5OPT=-Mylib
  $ prove

= BUGS

Please report any bugs or feature requests using the CPAN Request Tracker web
interface at [http://rt.cpan.org/Dist/Display.html?Queue=ylib]

When submitting a bug or request, please include a test-file or a patch to an
existing test-file that illustrates the bug or desired feature.

= SEE ALSO

* [lib]
* [rlib]
* [local::lib]

= AUTHOR

David A. Golden (DAGOLDEN)

= COPYRIGHT AND LICENSE

Copyright (c) 2009 by David A. Golden. All rights reserved.

Licensed under Apache License, Version 2.0 (the "License").
You may not use this file except in compliance with the License.
A copy of the License was distributed with this file or you may obtain a 
copy of the License from http://www.apache.org/licenses/LICENSE-2.0

Files produced as output though the use of this software, shall not be
considered Derivative Works, but shall be considered the original work of the
Licensor.

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

=end wikidoc

=cut

