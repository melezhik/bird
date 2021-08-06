#!perl6

use v6;

unit module Bird::DSL::K8s;

use Bird;

our sub k8s-deployment-has ($dpl,$namespace,$cnt,*%config) is export {

      update-cmd-file qq:to/HERE/;
      if ! test -f \$cache_root_dir/k8s_dpl_{$dpl}_{$namespace}.json; then
        kubectl get deployment $dpl -n $namespace -o json > \$cache_root_dir/k8s_dpl_{$dpl}_{$namespace}.json
      fi
      HERE

      update-state-file qq:to/HERE/;
      note: k8s dpl {$dpl}\@{$namespace} has
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

