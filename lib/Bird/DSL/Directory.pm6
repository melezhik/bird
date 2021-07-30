#!perl6

use v6;

unit module Bird::DSL::Directory;

use Bird;

our sub directory-exists ($path) is export {

    update-cmd-file qq:to/HERE/;
    if test -d $path; then echo "directory $path exists"; else echo "directory $path does not exist"; fi
    HERE

    update-state-file qq:to/HERE/;
    directory $path exists
    HERE

}

