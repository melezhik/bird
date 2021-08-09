#!perl6

use v6;

unit module Bird::DSL::File;

use Bird;

my %cache;

our sub file-exists ($path) is export {

    update-cmd-file qq:to/HERE/;
    if test -f $path; then echo "file $path exists"; else echo "file $path does not exist"; fi
    HERE

    update-state-file qq:to/HERE/;
    file $path exists
    HERE

}


our sub file-has-line (Str:D $path,*@lines) is export {

    update-cmd-file qq:to/HERE/;
    {cmd-header("file $path has line {@lines.perl} ?")}
    cat $path
    {cmd-footer()}
    HERE

    update-state-file qq:to/HERE/;
    {state-header("file $path has line {@lines.perl} ?")}
    {@lines.join("\n")}
    {state-footer()}
    HERE

}

our sub file-data-not-empty (Str:D $path,*@pattern) is export {

    my $cmd-id = %cache<file-data-not-empty>++;

    update-cmd-file cmd-header("file [$path] none empty data. id={$cmd-id}");
    my @c;
    for @pattern -> $pattern {
        @c.push: "s/($pattern)\\S+/\$1.\"[censored]\"/ge";
        @c.push: "s/(.*$pattern)/\">>>\".\$1/ge";
    }
    update-cmd-file "perl -n -e '{@c.join: '; '}; print' $path";
    update-cmd-file cmd-footer();

    update-state-file state-header("file [$path] none empty data. id={$cmd-id}");
    update-state-file "regexp: ^^ '>>>' ";
    update-state-file state-footer();

    update-state-file q:to/HERE/;
    generator: <<RAKU
    !perl6
    for matched()<> -> $ml {
      say "assert: ", $ml ~~ /'[censored]'/ ?? 1 !! 0, " $ml is not empty";
    }
    RAKU
    HERE

}

our sub file-has-permission ($path, %permissions-hash) is export {

  if %permissions-hash<read-all> {

    update-cmd-file qq:to/HERE/;
    {cmd-header("file $path is readable by all ?")}
    stat -c%A $path
    {cmd-footer()}
    HERE

    my $check = 'regexp: ^^^ \S "r"\S\S "r"\S\S "r"\S\S $$';

    update-state-file qq:to/HERE/;
    {state-header("file $path is readable by all ?")}
      $check
    {state-footer()}
    HERE

  }

  if %permissions-hash<write-all> {

    update-cmd-file qq:to/HERE/;
    {cmd-header("file $path is writable by all ?")}
    stat -c%A $path
    {cmd-footer()}
    HERE

    my $check = 'regexp: ^^^ \S  \S"w"\S  \S"w"\S \S"w"\S $$';

    update-state-file qq:to/HERE/;
    {state-header("file $path is writable by all ?")}
      $check
    {state-footer()}
    HERE

  }

  if %permissions-hash<execute-all> {

    update-cmd-file qq:to/HERE/;
    {cmd-header("file $path is executable by all ?")}
    stat -c%A $path
    {cmd-footer()}
    HERE

    my $check = 'regexp: ^^^ \S  \S\S"x"  \S\S"x" \S\S"x" $$';

    update-state-file qq:to/HERE/;
    {state-header("file $path is executable by all ?")}
      $check
    {state-footer()}
    HERE

  }

}


