#!perl6

use v6;

unit module Bird::DSL::K8s;

use Bird;

our sub k8s-deployment-has ($dpl,$namespace,$cnt,%config = %()) is export {

  update-cmd-file "kubectl get deployment $dpl -n $namespace -o json > /tmp/.k8s-dpl-data.json";

  if %config<env> {

      my $head = mk-header "k8s deployment name=$dpl namepspace=$namespace container=$cnt has env";

      update-cmd-file qq:to/HERE/;
      {cmd-header($head)}
      cat /tmp/.k8s-dpl-data.json | jq -r '.spec.template.spec.containers | .[] | select(.name == "$cnt") | .env | .[] | .name'
      {cmd-footer()};
      HERE

      update-state-file qq:to/HERE/;
      note: $head 
      note: {%config<env>.perl}
      {state-header($head)}
      HERE

      for %config<env><> -> $i {
        update-state-file($i)
      }

      update-state-file(state-footer());

  }

  if %config<command> {

      my $head = mk-header "k8s deployment name=$dpl namepspace=$namespace container=$cnt has command";

      update-cmd-file qq:to/HERE/;
      {cmd-header($head)}
      cat /tmp/.k8s-dpl-data.json | jq -r '.spec.template.spec.containers | .[] | select(.name == "$cnt") | .command | .[]'
      {cmd-footer()};
      HERE

      update-state-file qq:to/HERE/;
      note: $head
      begin:
      $head
      HERE

      if %config<command>.isa(Str) {
        update-state-file(%config<command>);
      } else {
        for %config<command><> -> $i {
          update-state-file($i)
        }
      }
      update-state-file(state-footer());

  }

  if %config<command-args> {

    my $head = mk-header "k8s deployment name=$dpl namepspace=$namespace container=$cnt has command-args";

    update-cmd-file qq:to/HERE/;
    {cmd-header($head)}
    cat /tmp/.k8s-dpl-data.json | jq -r '.spec.template.spec.containers | .[] | select(.name == "$cnt") | .args | .[]'
    {cmd-footer()};
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

    update-state-file(state-footer());

  }


  if %config<volume-mounts> {

      my $head = mk-header "k8s deployment name=$dpl namepspace=$namespace container=$cnt has volume-mounts";

      update-cmd-file cmd-header($head);
      update-cmd-file Q{cat /tmp/.k8s-dpl-data.json | jq -r '.spec.template.spec.containers | .[] | select(.name == "} ~ 
      $cnt ~ Q{") | .volumeMounts | .[] | "[\(.name) \(.mountPath)@\(.subPath)]"'};
      update-cmd-file cmd-footer();

      update-state-file qq:to/HERE/;
      note: $head 
      note: {%config<volume-mounts>.perl}
      $head
      HERE

      if %config<volume-mounts>.isa(Array) {
        for %config<volume-mounts><> -> $i {
          my $v = $i ~~ /'@'/ ?? $i !! "{$i}@null";
          update-state-file("[$v]")
        }
      } else {
        my %h = %config<volume-mounts>;
        for %h -> $i {
          my $v = $i.value ~~ /'@'/ ?? $i.value !! "{$i.value}@null";
          update-state-file("[{$i.key} {$v}]")
        }
      }

      update-state-file(state-footer());

  }

}

