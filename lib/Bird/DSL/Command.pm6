#!perl6

use v6;

unit module Bird::DSL::Command;

use Bird;

our sub command-has-stdout (Str:D $cmd,*@lines) is export {

    my $head = mk-header "command [$cmd] has stdout";

    update-cmd-file qq:to/HERE/;
    {cmd-header($head)}
    $cmd
    {cmd-footer()}
    HERE

    update-state-file qq:to/HERE/;
    note: $head 
    note: {@lines.perl}
    {state-header($head)}
    {@lines.join("\n")}
    {state-footer()}
    HERE

}

our sub command-exit-code (Str:D $cmd,$code) is export {

    my $head = mk-header "command [$cmd] has exit code";

    update-cmd-file qq:to/HERE/;
    {cmd-header($head)}
    $cmd 1>/dev/null 2>&1; echo "command [$cmd] exit code [\$?]"
    {cmd-footer()}
    HERE

    update-state-file qq:to/HERE/;
    note: $head [$code]
    {state-header($head)}
    command [$cmd] exit code [$code]
    {state-footer()}
    HERE

}

