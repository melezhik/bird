#!perl6

use v6;

unit module Bird::DSL::Directory;

use Bird;

our sub directory-exists ($path) is export {

    update-cmd-file qq:to/HERE/;
    echo '<<< dir $path exists ?'
    test -d $path && echo dir exists
    echo '>>>'
    HERE

    update-state-file qq:to/HERE/;
    between: \{ ^^^ '<<< dir $path exists ?'  \} \{ ^^^ '>>>' \}
      note: [dir $path exists ?]
      regexp: ^^^ 'dir exists'
    end:
    HERE

}

