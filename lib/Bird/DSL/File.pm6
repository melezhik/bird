#!perl6

use v6;

unit module Bird::DSL::File;

use Bird;

our sub file-exists ($path) is export {

    update-cmd-file qq:to/HERE/;
    {cmd-header("file $path exists ?")}
    test -f $path && echo file exists
    {cmd-footer()}
    HERE

    update-state-file qq:to/HERE/;
    {state-header("file $path exists ?")}
      regexp: ^^^ 'file exists'
    {state-footer()}
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


