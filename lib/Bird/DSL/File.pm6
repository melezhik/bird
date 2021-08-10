#!perl6

use v6;

unit module Bird::DSL::File;

use Bird;

our sub file-exists ($path) is export {
  
    my $head = mk-header "file $path exists";

    update-cmd-file qq:to/HERE/;
    {cmd-header($head)}
    if test -f $path; then 
      echo "file $path exists"; 
    else echo "file $path does not exist"; 
    fi
    {cmd-footer()}
    HERE

    update-state-file qq:to/HERE/;
    {state-header($head)}
    file $path exists
    {state-footer()}
    HERE

}


our sub file-has-line (Str:D $path,*@lines) is export {

    my $head = mk-header "file $path has lines";

    update-cmd-file qq:to/HERE/;
    {cmd-header($head)}
    cat $path
    {cmd-footer()}
    HERE

    update-state-file qq:to/HERE/;
    note: $head {@lines.perl}
    {state-header($head)}
    {@lines.join("\n")}
    {state-footer()}
    HERE

}

our sub file-data-not-empty (Str:D $path,*@pattern) is export {

    my $head = mk-header "file $path data not empty";

    update-cmd-file cmd-header($head);

    my @c;
    for @pattern -> $pattern {
        @c.push: "s/($pattern)\\S+/\$1.\"[censored]\"/ge";
        @c.push: "s/(.*$pattern)/\">>>\".\$1/ge";
    }
    update-cmd-file "perl -n -e '{@c.join: '; '}; print' $path";
    update-cmd-file cmd-footer();

    update-state-file qq:to/HERE/;
    note: $head {@pattern.perl}
    {state-header($head)}
    regexp: ^^ '>>>' 
    {state-footer()}
    HERE

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

    my $head = mk-header "file $path is readable by all";

    update-cmd-file qq:to/HERE/;
    {cmd-header($head)}
    stat -c%A $path
    {cmd-footer()}
    HERE

    my $check = 'regexp: ^^^ \S "r"\S\S "r"\S\S "r"\S\S $$';

    update-state-file qq:to/HERE/;
    note: $head
    {state-header($head)}
      $check
    {state-footer()}
    HERE

  }

  if %permissions-hash<write-all> {

    my $head = mk-header "file $path is writtable by all";

    update-cmd-file qq:to/HERE/;
    {cmd-header($head)}
    stat -c%A $path
    {cmd-footer()}
    HERE

    my $check = 'regexp: ^^^ \S  \S"w"\S  \S"w"\S \S"w"\S $$';

    update-state-file qq:to/HERE/;
    note: $head
    {state-header($head)}
      $check
    {state-footer()}
    HERE

  }

  if %permissions-hash<execute-all> {

    my $head = mk-header "file $path is executable by all";

    update-cmd-file qq:to/HERE/;
    {cmd-header($head)}
    stat -c%A $path
    {cmd-footer()}
    HERE

    my $check = 'regexp: ^^^ \S  \S\S"x"  \S\S"x" \S\S"x" $$';

    update-state-file qq:to/HERE/;
    note: $head
    {state-header($head)}
      $check
    {state-footer()}
    HERE

  }

}


