#!perl6

use v6;

unit module Bird::DSL::Pip;

use Bird;

our sub pip3-package-installed ($package) is export {

    my @packages = $package.isa(List) ?? $package<> !! $package;

    my $head = mk-header "pip3 package(s) installed";

    update-cmd-file(cmd-header($head));

    update-state-file("note: $head {$package.perl}");

    update-state-file(state-header($head));

    for @packages -> $p {

      update-cmd-file "pip3 list 2>&1 | grep '$p'";

      update-state-file "regexp: ^^ '{$p}' \\s+";
    
    }

    update-cmd-file(cmd-footer());

    update-state-file(state-footer());

}

