#!perl6

use v6;

unit module Bird::DSL::Command;

use Bird;

our sub command-has-stdout (Str:D $cmd,*@lines) is export {

    update-cmd-file qq:to/HERE/;
    {cmd-header("command [$cmd] has stdout {@lines.perl} ?")}
    $cmd
    {cmd-footer()}
    HERE

    update-state-file qq:to/HERE/;
    {state-header("command [$cmd] has stdout {@lines.perl} ?")}
    {@lines.join("\n")}
    {state-footer()}
    HERE

}

our sub command-exit-code (Str:D $cmd,$code) is export {

    update-cmd-file qq:to/HERE/;
    $cmd 1>/dev/null 2>&1; echo "command [$cmd] exit code [\$?]"
    HERE

    update-state-file qq:to/HERE/;
    command [$cmd] exit code [$code]
    HERE

}

