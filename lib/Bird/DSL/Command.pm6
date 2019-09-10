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

