#!perl6

use v6;

unit module Bird::DSL::Directory;

use Bird;

our sub directory-exists ($path) is export {

    my $head = mk-header "directory $path exists";

    update-cmd-file qq:to/HERE/;
    {cmd-header($head)}
    if test -d $path; then echo "directory $path exists"; else echo "directory $path does not exist"; fi
    {cmd-footer()}
    HERE

    update-state-file qq:to/HERE/;
    note: $head
    {state-header($head)}
    directory $path exists
    {state-footer()}
    HERE

}

