# Bird 🐦

Bird - Alternative to Chef Inspec Written in Raku.

It's written in Raku and exposes pure Raku API.

# WARNING ⚠️

Bird is under active development now, things might change.

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

    directory-exists "{%*ENV<HOME>}";

    file-exists "{%*ENV<HOME>}/.bashrc";

    bash "echo hello > /tmp/bird.tmp";

    bash "echo bird >> /tmp/bird.tmp";

    file-has-line "/tmp/bird.tmp", "hello", "bird";

    file-has-permission "documentation/dsl.md", %( read-all => True );
    file-has-permission "bin/bird", %( execute-all => True, read-all => True );

    bash "chmod a+r /tmp/bird.tmp";

    bash "chmod a+w /tmp/bird.tmp";

    file-has-permission "/tmp/bird.tmp", %( write-all => True, read-all => True );

    command-has-stdout "echo hello; echo bird", "hello", "bird";

    command-exit-code "raku --version", 0;

    package-installed "nano";

    pip3-package-installed "PyYAML";

    file-has-permission "rules.pl6", %( read-all => True );

    package-installed "nano";

    bash "echo username=admin > /tmp/creds.txt; echo password=123 >> /tmp/creds.txt;";

    file-data-not-empty "/tmp/creds.txt",
      "username=", "password=";

Run checks against hosts:

`bird`

```
bird:: [read hosts from file] [hosts.pl6]
bird:: [cmd file] [/root/.bird/2587814/cmd.sh]
bird:: [check file] [/root/.bird/2587814/state.check]
bird:: [init cmd file]
[bash: echo hello > /tmp/bird.tmp] :: <empty stdout>
[bash: echo bird >> /tmp/bird.tmp] :: <empty stdout>
[bash: chmod a+r /tmp/bird.tmp] :: <empty stdout>
[bash: chmod a+w /tmp/bird.tmp] :: <empty stdout>
[bash: echo username=admin > /tmp/creds.txt; echo passwor ...] :: <empty stdout>
[repository] :: index updated from file:///root/repo/api/v1/index
[check my hosts] :: check host [localhost] ...
[check my hosts] :: directory /root exists
[check my hosts] :: file /root/.bashrc exists
[check my hosts] :: <<< file /tmp/bird.tmp has line ["hello", "bird"] ?
[check my hosts] :: hello
[check my hosts] :: bird
[check my hosts] :: >>>
[check my hosts] :: <<< file documentation/dsl.md is readable by all ?
[check my hosts] :: -rw-r--r--
[check my hosts] :: >>>
[check my hosts] :: <<< file bin/bird is readable by all ?
[check my hosts] :: -rwxr-xr-x
[check my hosts] :: >>>
[check my hosts] :: <<< file bin/bird is executable by all ?
[check my hosts] :: -rwxr-xr-x
[check my hosts] :: >>>
[check my hosts] :: <<< file /tmp/bird.tmp is readable by all ?
[check my hosts] :: -rw-rw-rw-
[check my hosts] :: >>>
[check my hosts] :: <<< file /tmp/bird.tmp is writable by all ?
[check my hosts] :: -rw-rw-rw-
[check my hosts] :: >>>
[check my hosts] :: <<< command [echo hello; echo bird] has stdout ["hello", "bird"] ?
[check my hosts] :: hello
[check my hosts] :: bird
[check my hosts] :: >>>
[check my hosts] :: command [raku --version] exit code [0]
[check my hosts] :: Installed Packages
[check my hosts] :: nano.x86_64                         2.9.8-1.el8                          @baseos
[check my hosts] :: package nano is installed
[check my hosts] :: <<< pip3 package PyYAML is installed?
[check my hosts] :: stderr: WARNING: You are using pip version 21.1.2; however, version 21.2.3 is available.
You should consider upgrading via the '/usr/bi
[check my hosts] :: stderr: n/python3.6 -m pip install --upgrade pip' command.
[check my hosts] :: PyYAML              3.12
[check my hosts] :: >>>
[check my hosts] :: <<< file rules.pl6 is readable by all ?
[check my hosts] :: -rw-r--r--
[check my hosts] :: >>>
[check my hosts] :: Installed Packages
[check my hosts] :: nano.x86_64                         2.9.8-1.el8                          @baseos
[check my hosts] :: package nano is installed
[check my hosts] :: <<< file [/tmp/creds.txt] none empty data [["username=", "password="]]
[check my hosts] :: username= censored
[check my hosts] :: password= censored
[check my hosts] :: >>>
[check my hosts] :: end check host [localhost]
[check my hosts] :: ==========================================================
[task check] stdout match <directory /root exists> True
[task check] stdout match <file /root/.bashrc exists> True
[task check] [file /tmp/bird.tmp has line ["hello", "bird"] ?]
[task check] stdout match (r) <hello> True
[task check] stdout match (r) <bird> True
[task check] [file documentation/dsl.md is readable by all ?]
[task check] stdout match (r) <^^^ \S "r"\S\S "r"\S\S "r"\S\S $$> True
[task check] [file bin/bird is readable by all ?]
[task check] stdout match (r) <^^^ \S "r"\S\S "r"\S\S "r"\S\S $$> True
[task check] [file bin/bird is executable by all ?]
[task check] stdout match (r) <^^^ \S  \S\S"x"  \S\S"x" \S\S"x" $$> True
[task check] [file /tmp/bird.tmp is readable by all ?]
[task check] stdout match (r) <^^^ \S "r"\S\S "r"\S\S "r"\S\S $$> True
[task check] [file /tmp/bird.tmp is writable by all ?]
[task check] stdout match (r) <^^^ \S  \S"w"\S  \S"w"\S \S"w"\S $$> True
[task check] [command [echo hello; echo bird] has stdout ["hello", "bird"] ?]
[task check] stdout match (r) <hello> True
[task check] stdout match (r) <bird> True
[task check] stdout match <command [raku --version] exit code [0]> True
[task check] stdout match <package nano is installed> True
[task check] [pip3 package PyYAML is installed?]
[task check] stdout match (r) <^^ 'PyYAML' \s+> True
[task check] [file rules.pl6 is readable by all ?]
[task check] stdout match (r) <^^^ \S "r"\S\S "r"\S\S "r"\S\S $$> True
[task check] stdout match <package nano is installed> True
[task check] [file [/tmp/creds.txt] none empty data [["username=", "password="]]]
[task check] stdout match (r) <"username=" \s* censored> True
[task check] stdout match (r) <"password=" \s* censored> True
```

# Rules DSL

Rules DSL is special language to validate states of Linux host.

This is just plain Raku functions:

    file-exists "{%*ENV<HOME>}/.bashrc";

The full list of DSL functions available [here](https://github.com/melezhik/bird/blob/master/documentation/dsl.md).

# Ssh hosts

There are two ways to set ssh hosts:

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
