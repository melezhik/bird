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

