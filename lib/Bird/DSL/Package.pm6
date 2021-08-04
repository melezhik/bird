#!perl6

use v6;

unit module Bird::DSL::package;

use Bird;

our sub package-installed ($package) is export {

    my @packages = $package.isa(List) ?? $package<> !! $package;

    update-cmd-file %?RESOURCES<utils.sh>.Str.IO.slurp;

    for @packages -> $p {

      update-cmd-file qq:to/HERE/;
      if test "\$os" = "debian" || test "\$os" = "ubuntu"; then
        if dpkg -s $p 1>/dev/null 2>&1; then echo "package $p is installed"; else echo "package $p is not installed"; fi
      else
        if yum list installed $p; then echo "package $p is installed"; else echo "package $p is not installed"; fi
      fi
      HERE

      update-state-file qq:to/HERE/;
      package $p is installed
      HERE

    }

}

our sub package-not-installed (Str:D $package) is export {

    update-cmd-file qq:to/HERE/;
    if test "\$os" = "debian" || test "\$os" = "ubuntu"; then
      if dpkg -s $package 1>/dev/null 2>&1; then 
        echo "package [$package] is installed"
      else
        echo "package [$package] is not installed"
      fi
    else
      if yum list installed $package 1>/dev/null 2>&1; then 
        echo "package [$package] is installed"
      else
        echo "package [$package] is not installed"
      fi
    fi
    HERE

    update-state-file qq:to/HERE/;
    package [$package] is not installed
    HERE

}
