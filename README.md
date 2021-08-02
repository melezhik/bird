# Bird 🐦

Bird - Alternative to Chef Inspec Written in Raku.

# WARNING ⚠️

Bird is under active development now, things might change.

It's written in Raku and exposes pure Raku API.

# Build Status

[![Build Status](https://travis-ci.org/melezhik/bird.svg?branch=master)](https://travis-ci.org/melezhik/bird)

# INSTALL

    zef install Bird

Bird uses Sparrow6 plugin `ssh-bulk-check` to do it's work, so one needs
to setup Sparrow6 repository:

    export SP6_REPO=http://sparrowhub.io/repo

To run check remotely install ssh-pass:

    sudo yum install sshpass

# USAGE

Create rules:

`cat rules.pl6`

    my $cls-id = "cls02";

    directory-exists "~/projects/cluster-install/$cl-_id/backup";

    directory-exists "~/projects/cluster-install/$cls-id/conf";

    file-exists "~/projects/cluster-install/$cls-id/conf/.exists";

    package-installed "python36";

    package-installed(["curl", "jq", "java-11-openjdk"]);

    pip3-package-installed(["python-openstackclient"]);

    command-has-stdout "keytool 2>&1 | head -n 4", "Key and Certificate Management Tool";


Run checks against hosts:

`bird --host=devstand01`

![bird report](https://raw.githubusercontent.com/melezhik/bird/master/bird-report.png)

# Rules DSL

Rules DSL is special language to validate states of Linux host.

This is just plain Raku functions:

    file-exists "{%*ENV<HOME>}/.bashrc";

The full list of DSL functions available [here](https://github.com/melezhik/bird/blob/master/documentation/dsl.md).

# Ssh hosts

There are two ways to set ssh hosts

## Command line

By using `--host`, `--user`, `--password` options:

    bird --host=192.168.0.1 --user=alex --password=PasSword

## Hosts.pl6

To define dynamic hosts configuration, use `hosts.pl6`, this should
be Raku script that returns `@Array` of hosts:

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
