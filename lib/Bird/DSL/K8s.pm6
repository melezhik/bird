#!perl6

use v6;

unit module Bird::DSL::K8s;

use Bird;

our sub k8s-deployment-has ($dpl,$namespace,$cnt,%config = %()) is export {

      update-cmd-file qq:to/HERE/;
      {cmd-header("kubectl get deployment $dpl -n $namespace")}
      kubectl get deployment $dpl -n $namespace -o json
      {cmd-footer()}
      HERE

      update-state-file qq:to/HERE/;
      {state-header("kubectl get deployment $dpl -n $namespace")}
      regexp: .*
      {state-footer()}
      generator: <<RAKU
      !perl6
      my \$dpl = \"$dpl\";
      my \$namespace = \"$namespace\";
      my \$cnt = \"$cnt\";
      my \$config = {%config.perl}
      {%?RESOURCES<k8s-deployment-check.raku>.Str.IO.slurp}
      RAKU
      HERE

}

