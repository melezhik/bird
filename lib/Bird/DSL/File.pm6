#!perl6

use v6;

unit module Bird::DSL::File;

use Bird;

our sub file-exists ($path) is export {

    update-cmd-file qq:to/HERE/;
    echo '<<< file $path exists ?'
    test -f $path && echo file exists
    echo '>>>'
    HERE

    update-state-file qq:to/HERE/;
    between: \{ ^^^ '<<< file $path exists ?'  \} \{ ^^^ '>>>' \}
      note: [file $path exists ?]
      regexp: ^^^ 'file exists'
    end:
    HERE

}

