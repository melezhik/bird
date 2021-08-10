use JSON::Tiny;
use MIME::Base64;

my $c = from-json captures().map({"$_"}).join("");

say "note: verify deployment. name={$dpl},namespace={$namespace},container={$cnt}";
$c = $c<spec><template><spec><containers>.grep({ .<name> eq $cnt })[0];

if $config<env> {

  my @e = ($c<env> ?? $c<env><> !! []).map({.<name>});

  for $config<env><> -> $e {
    say "assert: ", ( $e ~~  any @e ) ?? 1 !! 0, " env [$e] exists";
  }

}

if $config<volume-mounts> {

  my @v = ($c<volumeMounts> ?? $c<volumeMounts><> !! []).map({

    if .<subPath> {
      "{.<name>} {.<mountPath>}\@{.<subPath>}"
    } else {
      "{.<name>} {.<mountPath>}"
    }
    
  });

  if $config<volume-mounts>.isa(Array) {
    for $config<volume-mounts><> -> $i {
      say "assert: ", ( $i ~~  any @v ) ?? 1 !! 0, " mount [$i] exists";
    }
  } else {
    my %h = $config<volume-mounts>;
    for %h -> $i {
      say "assert: ", ( "{$i.key} {$i.value}" ~~  any @v ) ?? 1 !! 0, " mount [$i] exists";
    }
  }

}


if $config<command> {

  my $cmd = $c<command> ?? ($c<command>).join("\n") !! "";

  my $cmd-safe = $cmd.subst("\n","\\n",:g);
  my $config-cmd-safe = $config<command>.join("\n").subst("\n","\\n",:g);

  say "assert: ", $cmd-safe eq $config-cmd-safe ?? 1 !! 0, " command [$config-cmd-safe] == [$cmd-safe]";
 
}

if $config<args> {

  my $args = $c<args> ?? ($c<args>).join("\n") !! "";

  my $args-safe = $args.subst("\n","\\n",:g);
  my $config-args-safe = $config<args>.join("\n").subst("\n","\\n",:g);

  say "assert: ", $args-safe eq $config-args-safe ?? 1 !! 0, " command [$config-args-safe] == [$args-safe]";
 
}

=begin comment

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

