use JSON::Tiny;
use MIME::Base64;

my $c = from-json captures().map({"$_"}).join("");

if config<container> {
  say "note: verify deployment. name={$dpl},namespace={$namespace},container={$cnt}";
  $c = $c<spec><template><spec><containers>.grep({ .<name> eq $cnt })[0];
} else {
  $c = $c<spec><template><spec><containers>[0];
  say "note: verify deployment. name={$dpl},namespace={$namespace},container={$cnt}";
}

if $config<env> {

  my @e = ($c<env> ?? $c<env><> !! []).map({.<name>});

  for $config<env><> -> $e {
    say "assert: ", ( $e ~~  any @e ) ?? 1 !! 0, " env [$e] exists";
  }

}

=begin comment

if $c<volumeMounts> {

  say "[volume_mounts_start]";

  #say $c<volumeMounts>.perl;

  for $c<volumeMounts><> -> $i {
    #say $i<subPath>.exists ??  "[{$i<name>} {$i<mountPath>}\@$i<subPath>]" !! "[{$i<name>} {$i<mountPath>}]";
    if $i<subPath> {
      say "[{$i<name>} {$i<mountPath>}\@$i<subPath>]"
    } else {
      say "[{$i<name>} {$i<mountPath>}]"
    }
  }

  say "[volume_mounts_end]";

}

if $c<command> {

  say "[command_start]";

  #say $c<command>.perl;

  for $c<command><> -> $i {
    say $i;
  }

  say "[command_end]";

}

if $c<command> {

  say "[command_args_start]";

  #say $c<args>.perl;

  for $c<args><> -> $i {
    say $i;
  }

  say "[command_args_end]";

}


say "==================================================================";

=end comment

