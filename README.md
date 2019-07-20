# Bird

Bird - Lightweight Alternative to Chef Inspec Written in Perl6.

**rules.pl6**:

    directory-exists "{%*ENV<HOME>}";
    file-exists "{%*ENV<HOME>}/.bashrc";
    directory-exists "{%*ENV<HOME>}/yyy";
    
`$ bird`:

    bird:: [read hosts file from] [hosts.pl6]
    bird:: [cmd file] [/home/melezhik/.bird/71214/cmd.sh]
    bird:: [check file] [/home/melezhik/.bird/71214/state.check]
    00:48:35 07/20/2019 [check my hosts] check host [127.0.0.1] ...
    00:48:35 07/20/2019 [check my hosts] <<< dir /home/melezhik exists ?
    00:48:35 07/20/2019 [check my hosts] dir exists
    00:48:35 07/20/2019 [check my hosts] >>>
    00:48:35 07/20/2019 [check my hosts] <<< file /home/melezhik/.bashrc exists ?
    00:48:35 07/20/2019 [check my hosts] file exists
    00:48:35 07/20/2019 [check my hosts] >>>
    00:48:35 07/20/2019 [check my hosts] <<< dir /home/melezhik/yyy exists ?
    00:48:35 07/20/2019 [check my hosts] >>>
    00:48:35 07/20/2019 [check my hosts] end check host [127.0.0.1]
    [task check] [dir /home/melezhik exists ?]
    [task check] stdout match (r) <^^^ 'dir exists'> True
    [task check] [file /home/melezhik/.bashrc exists ?]
    [task check] stdout match (r) <^^^ 'file exists'> True
    [task check] [dir /home/melezhik/yyy exists ?]
    [task check] stdout match (r) <^^^ 'dir exists'> False
    =================
    TASK CHECK FAIL
    
# Install

    zef install Bird

Bird uses Sparrow6 plugin `ssh-bulk-check` to do it's work, so one need
to setup Sparrow6 repository, for example:

    export SP6_REPO=http://repo.southcentralus.cloudapp.azure.com

# Usage

Define rules:

**rules.pl6**

    file-exists "/home/bird/list.txt";
    file-has-line "/home/bird/list.txt", "sparrow", "crow";
    file-has-permission "/home/bird/list.txt", %( read-all => true, write-all => true );

Run checks:

    bird --host=192.168.0.1 --user=alex --password=PasSword!


# Rules DSL

Rules DSL is special language to validate states of Linux host.

This is just plain Perl6 functions:

    file-exists "{%*ENV<HOME>}/.bashrc";

A full list of DSL functions available [here](https://github.com/melezhik/bird/blob/master/documentation/dsl.md)

# Ssh hosts

There are two ways to set ssh hosts

## Command line

By using `--host`, `--user`, `--password` options:

    bird --host=192.168.0.1 --user=alex --password=PasSword


## Hosts.pl6

To define dynamic hosts configuration, use `hosts.pl6`, this should
be Perl6 script that returns `@Array` of hosts:

    [
      '192.168.0.1',
      'foo.bar.baz',
      # so on
    ]

For example:

    use Sparrow6::DSL;

    my %state = task-run "worker nodes", "ambari-hosts", %(
      ambari_host  => 'cluster.fqdn.host',
      admin => 'super-jack',
      password => 'PaSsWord123',
      cluster => "cluster01",
      node_type => "worker",
    );

    %state<hosts><>.map: { %i<ip> }

# Author

Alexey Melezhik

# See Also

[Chef Inspec](https://www.inspec.io/)
