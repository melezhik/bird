#!raku

use v6;

unit module Bird:ver<0.1.5>;

my $base-dir = "{%*ENV<HOME>}/.bird/{$*PID}{22.rand.Int.Str}";

mkdir "{%*ENV<HOME>}/.bird/";
mkdir $base-dir;

our sub cmd-file () is export { "$base-dir/cmd.sh" } 
our sub state-file () is export { "$base-dir/state.check" } 

unlink cmd-file() if cmd-file.IO ~~ :f;
unlink state-file() if state-file.IO ~~ :f;

our sub cmd-file-init () is export {
  say "bird:: [init cmd file]";
  update-cmd-file %?RESOURCES<utils.sh>.Str.IO.slurp;
}

our sub log ($header,$footer) is export {
  say "bird:: [$header] [$footer]"
}

our sub update-cmd-file ($data) is export {

  my $fh = open cmd-file(), :a;

  $fh.say($data);

  $fh.close;

}

our sub update-state-file ($data) is export {

  my $fh = open state-file, :a;

  $fh.say($data);

  $fh.close;

}

our sub  cmd-header ($check) is export {

  return "echo '<<< $check'"

}

our sub  cmd-footer () is export {

  return "echo '>>>'"

}

our sub  state-header ($check) is export {

  return (
    "between: \{ ^^^ '<<< $check' \$\$ \} \{ ^^^ '>>>' \$\$ \}",
    " note: [$check]"
  ).join("\n");
}

our sub  state-footer () is export {

  return "end:"

}
