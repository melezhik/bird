#!perl6

use v6;

unit module Bird::DSL::Pip;

use Bird;

our sub pip3-package-installed ($package) is export {

    my @packages = $package.isa(List) ?? $package<> !! $package;

    for @packages -> $p {
      update-cmd-file qq:to/HERE/;
      {cmd-header("pip3 package $p is installed?")}
      pip3 list| grep '$p'
      {cmd-footer()}
      HERE

      update-state-file qq:to/HERE/;
      {state-header("pip3 package $p is installed?")}
      regexp: ^^ '{$p}' \\s+
      {state-footer()}
      HERE
    }
}

