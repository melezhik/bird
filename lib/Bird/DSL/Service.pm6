#!perl6

use v6;

unit module Bird::DSL::Service;

use Bird;

our sub service-is-running (Str:D $srv) is export {

    my $head = mk-header "service [$srv] is running";

    update-cmd-file qq:to/HERE/;
    {cmd-header($head)}
    systemctl is-active $srv >/dev/null 2>&1 && echo YES || echo NO
    {cmd-footer()}
    HERE

    update-state-file qq:to/HERE/;
    note: $head 
    {state-header($head)}
    YES
    {state-footer()}
    HERE

}

our sub service-is-enabled (Str:D $srv) is export {

    my $head = mk-header "service [$srv] is enabled";

    update-cmd-file qq:to/HERE/;
    {cmd-header($head)}
    systemctl is-active $srv >/dev/null 2>&1 && echo YES || echo NO
    {cmd-footer()}
    HERE

    update-state-file qq:to/HERE/;
    note: $head 
    {state-header($head)}
    YES
    {state-footer()}
    HERE

}



our sub service-listen-to (Str:D $srv, $port, $localhost = False ) is export {

    my $head = mk-header "service [$srv] listens to port [$port]";

    update-cmd-file qq:to/HERE/;
    {cmd-header($head)}
    lsof -T -Pi :$port
    {cmd-footer()}
    HERE

    my $listen-pattern = $localhost ?? "localhost" !! "*";

    update-state-file qq:to/HERE/;
    note: $head 
    {state-header($head)}
    regexp: ^^ $srv \\s+ \\S+ .* '$listen-pattern' ':' $port \$\$
    {state-footer()}
    HERE

}


