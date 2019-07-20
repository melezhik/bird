#!perl6

use v6;

unit module Bird:ver<0.1.0>;

my $base-dir = "{%*ENV<HOME>}/.bird/{$*PID}{22.rand.Int.Str}";

mkdir "{%*ENV<HOME>}/.bird/";
mkdir $base-dir;

our sub cmd-file () is export { "$base-dir/cmd.sh" } 
our sub state-file () is export { "$base-dir/state.check" } 

unlink cmd-file() if cmd-file.IO ~~ :f;
unlink state-file() if state-file.IO ~~ :f;

our sub log ($header,$footer) is export {
  say "bird:: [$header] [$footer]"
}

our sub directory-exists ($path) is export {

    update-cmd-file qq:to/HERE/;
    echo '<<< dir $path exists ?'
    test -d $path && echo dir exists
    echo '>>>'
    HERE

    update-state-file qq:to/HERE/;
    between: \{ ^^^ '<<< dir $path exists ?'  \} \{ ^^^ '>>>' \}
      note: [dir $path exists ?]
      regexp: ^^^ 'dir exists'
    end:
    HERE

}

our sub file-exists ($path) is export {

    update-cmd-file qq:to/HERE/;
    echo '<<< file $path exists ?'
    test -f $path && echo file exists
    echo '>>>'
    HERE

    update-state-file qq:to/HERE/;
    between: \{ ^^^ '<<< file $path exists ?'  \} \{ ^^^ '>>>' \}
      note: [file $path exists ?]
      regexp: ^^^ 'file exists'
    end:
    HERE

}

sub update-cmd-file ($data) {

  my $fh = open cmd-file(), :a;

  $fh.say($data);

  $fh.close;

}

sub update-state-file ($data) {

  my $fh = open state-file, :a;

  $fh.say($data);

  $fh.close;

}
