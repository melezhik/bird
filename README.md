# Bird

Bird - Alternative to Chef Inspec Written in Perl6.

# WARING

Bird is under active development now, but you can you give it a try and see how it differs from other tool.
It's written in Perl6 and exposes pure Perl6 API.

# Build Status

[![Build Status](https://travis-ci.org/melezhik/bird.svg?branch=master)](https://travis-ci.org/melezhik/bird)

# INSTALL

    zef install Bird

Bird uses Sparrow6 plugin `ssh-bulk-check` to do it's work, so one need
to setup Sparrow6 repository, for example:

    export SP6_REPO=http://repo.westus.cloudapp.azure.com/

To run check remotely install ssh-pass:

    sudo yum install sshpass

# USAGE

Create rules:

**rules.pl6**:

    directory-exists "{%*ENV<HOME>}";
    file-exists "{%*ENV<HOME>}/.bashrc";
    directory-exists "{%*ENV<HOME>}/yyy";

Run checks against hosts:

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

# Rules DSL

Rules DSL is special language to validate states of Linux host.

This is just plain Perl6 functions:

    file-exists "{%*ENV<HOME>}/.bashrc";

The full list of DSL functions available [here](https://github.com/melezhik/bird/blob/master/documentation/dsl.md)

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

# cli options

* `--rules`

Path to rules file. If not set `rules.pl` in cwd is taken


* `--password`

Ssh password. Optional

* `--user`

Ssh user. Optional


* `--host`

Ssh host. Optional, see also `hosts.pl6`

* `--verbose`

Verbose mode. Not used now. Reserved for the future


# Author

Alexey Melezhik

# See Also

* [Chef Inspec](https://www.inspec.io/)
* [Goss](https://github.com/aelsabbahy/goss)
