#!perl6

use v6;

unit module Bird::DSL::K8s;

use Bird;

our sub k8s-deployment-has ($dpl,$namespace,$cnt,%config = %()) is export {

      update-cmd-file "kubectl get deployment $dpl -n $namespace -o json > data.json";

      if %config<command-args> {

        my $head = mk-header "k8s deployment name=$dpl namepspace=$namespace container=$cnt has command-args";

        update-cmd-file qq:to/HERE/;
        {cmd-header($head)}
        cat data.json | jq -r '.spec.template.spec.containers | .[] | select(.name == "$cnt") | .args | .[]'
        HERE

        update-state-file qq:to/HERE/;
        note: $head
        begin:
        $head
        HERE

        if %config<command-args>.isa(Str) {
          update-state-file(%config<command-args>);
        } else {
          for %config<command-args><> -> $i {
            update-state-file($i)
          }
        }

        update-state-file("end:")

    }

}

