#!perl6

use v6;

unit module Bird::DSL::package;

use Bird;

our sub package-installed ($package) is export {

    my @packages = $package.isa(List) ?? $package<> !! $package;

    my $head = mk-header "package(s) installed";

    update-cmd-file(cmd-header($head));

    update-state-file("note: $head {$package.perl}");

    update-state-file(state-header($head));

    for @packages -> $p {

      update-cmd-file qq:to/HERE/;
      if test "\$os" = "debian" || test "\$os" = "ubuntu"; then
        if dpkg -s $p 1>/dev/null 2>&1; then echo "package $p is installed"; else echo "package $p is not installed"; fi
      elif test "\$os" = "openbsd"; then
        if pkg_info -e '$p' 1>/dev/null 2>&1; then echo "package $p is installed"; else echo "package $p is not installed"; fi
      else
        if yum list installed $p; then echo "package $p is installed"; else echo "package $p is not installed"; fi
      fi
      HERE

      update-state-file("package $p is installed");

    }

    update-cmd-file(cmd-footer());

    update-state-file(state-footer());

}


our sub package-not-installed ($package) is export {

    my @packages = $package.isa(List) ?? $package<> !! $package;

    my $head = mk-header "package(s) not installed";

    update-cmd-file(cmd-header($head));

    update-state-file("note: $head {$package.perl}");

    update-state-file(state-header($head));

    for @packages -> $p {

      update-cmd-file qq:to/HERE/;
      if test "\$os" = "debian" || test "\$os" = "ubuntu"; then
        if dpkg -s $p 1>/dev/null 2>&1; then echo "package $p is installed"; else echo "package $p is not installed"; fi
      elif test "\$os" = "openbsd"; then
        if pkg_info -e '$p' 1>/dev/null 2>&1; then echo "package $p is installed"; else echo "package $p is not installed"; fi
      else
        if yum list installed $p; then echo "package $p is installed"; else echo "package $p is not installed"; fi
      fi
      HERE

      update-state-file("package $p is not installed");

    }

    update-cmd-file(cmd-footer());

    update-state-file(state-footer());

}
