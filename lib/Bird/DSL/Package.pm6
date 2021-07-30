#!perl6

use v6;

unit module Bird::DSL::package;

use Bird;

our sub package-installed ($package) is export {

    my @packages = $package.isa(List) ?? $package<> !! $package;

    for @packages -> $p {

      update-cmd-file qq:to/HERE/;
      if yum list installed $p; then echo "package $p is installed"; else echo "package $p is not installed"; fi
      HERE

      update-state-file qq:to/HERE/;
      package $p is installed
      HERE

    }

}

