#!perl6

use v6;

unit module Bird::DSL::Directory;

use Bird;

our sub directory-exists ($path) is export {

    update-cmd-file qq:to/HERE/;
    {cmd-header("directory $path exists ?")}
    test -d $path && echo directory exists
    {cmd-footer()}
    HERE

    update-state-file qq:to/HERE/;
    {state-header("directory $path exists ?")}
      regexp: ^^^ 'directory exists'
    {state-footer()}
    HERE

}

