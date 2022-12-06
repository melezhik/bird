# Bird 🐦

Bird - Raku DSL for Linux Servers Verification.

It's written in Raku and exposes pure Raku API.

# WARNING ⚠️

Bird is under active development now, things might change.

# Build Status

[![SparrowCI](https://ci.sparrowhub.io/project/gh-melezhik-bird/badge)](https://ci.sparrowhub.io)

# INSTALL

    zef install Bird

Bird uses Sparrow6 plugin `ssh-bulk-check` to do it's work, so one needs
to setup Sparrow6 repository:

    export SP6_REPO=http://sparrowhub.io/repo

To run check remotely install ssh-pass:

    sudo yum install sshpass

# USAGE

Create rules:

`cat rules.raku`

```raku
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

file-has-permission "rules.raku", %( read-all => True );

package-installed "nano";

bash "echo username=admin > /tmp/creds.txt; echo password=123 >> /tmp/creds.txt;";

file-data-not-empty "/tmp/creds.txt",
  "username=", "password=";
```

Run checks against hosts:

`bird`

```
bird:: [read hosts from file] [hosts.raku]
bird:: [cmd file] [/root/.bird/274302/cmd.sh]
bird:: [check file] [/root/.bird/274302/state.check]
bird:: [init cmd file]
[bash: echo hello > /tmp/bird.tmp] :: <empty stdout>
[bash: echo bird >> /tmp/bird.tmp] :: <empty stdout>
[bash: chmod a+r /tmp/bird.tmp] :: <empty stdout>
[bash: chmod a+w /tmp/bird.tmp] :: <empty stdout>
[bash: echo username=admin > /tmp/creds.txt; echo passwor ...] :: <empty stdout>
[repository] :: index updated from file:///root/repo/api/v1/index
[check my hosts] :: check host [localhost]
[check my hosts] :: ==========================================================
[check my hosts] :: <<< test_01: directory /root exists
[check my hosts] :: directory /root exists
[check my hosts] :: >>>
[check my hosts] :: <<< test_02: file /root/.bashrc exists
[check my hosts] :: file /root/.bashrc exists
[check my hosts] :: >>>
[check my hosts] :: <<< test_03: file /tmp/bird.tmp has lines
[check my hosts] :: hello
[check my hosts] :: bird
[check my hosts] :: >>>
[check my hosts] :: <<< test_04: file documentation/dsl.md is readable by all
[check my hosts] :: -rw-r--r--
[check my hosts] :: >>>
[check my hosts] :: <<< test_05: file bin/bird is readable by all
[check my hosts] :: -rwxr-xr-x
[check my hosts] :: >>>
[check my hosts] :: <<< test_06: file bin/bird is executable by all
[check my hosts] :: -rwxr-xr-x
[check my hosts] :: >>>
[check my hosts] :: <<< test_07: file /tmp/bird.tmp is readable by all
[check my hosts] :: -rw-rw-rw-
[check my hosts] :: >>>
[check my hosts] :: <<< test_08: file /tmp/bird.tmp is writtable by all
[check my hosts] :: -rw-rw-rw-
[check my hosts] :: >>>
[check my hosts] :: <<< test_09: command [echo hello; echo bird] has stdout
[check my hosts] :: hello
[check my hosts] :: bird
[check my hosts] :: >>>
[check my hosts] :: <<< test_10: command [raku --version] has exit code
[check my hosts] :: command [raku --version] exit code [0]
[check my hosts] :: >>>
[check my hosts] :: <<< test_11: package(s) installed
[check my hosts] :: Installed Packages
[check my hosts] :: nano.x86_64                         2.9.8-1.el8                          @baseos
[check my hosts] :: package nano is installed
[check my hosts] :: >>>
[check my hosts] :: <<< test_12: pip3 package(s) installed
[check my hosts] :: PyYAML              3.12
[check my hosts] :: >>>
[check my hosts] :: <<< test_13: file rules.raku is readable by all
[check my hosts] :: -rw-r--r--
[check my hosts] :: >>>
[check my hosts] :: <<< test_14: package(s) installed
[check my hosts] :: Installed Packages
[check my hosts] :: nano.x86_64                         2.9.8-1.el8                          @baseos
[check my hosts] :: package nano is installed
[check my hosts] :: >>>
[check my hosts] :: <<< test_15: file /tmp/creds.txt data not empty
[check my hosts] :: >>> username=[censored]
[check my hosts] :: >>> password=[censored]
[check my hosts] :: >>>
[check my hosts] :: end check host [localhost]
[check my hosts] :: ==========================================================
[task check] verify host [localhost] start
[task check] test_01: directory /root exists
[task check] stdout match (r) <directory /root exists> True
[task check] test_02: file /root/.bashrc exists
[task check] stdout match (r) <file /root/.bashrc exists> True
[task check] test_03: file /tmp/bird.tmp has lines ["hello", "bird"]
[task check] stdout match (r) <hello> True
[task check] stdout match (r) <bird> True
[task check] test_04: file documentation/dsl.md is readable by all
[task check] stdout match (r) <^^^ \S "r"\S\S "r"\S\S "r"\S\S $$> True
[task check] test_05: file bin/bird is readable by all
[task check] stdout match (r) <^^^ \S "r"\S\S "r"\S\S "r"\S\S $$> True
[task check] test_06: file bin/bird is executable by all
[task check] stdout match (r) <^^^ \S  \S\S"x"  \S\S"x" \S\S"x" $$> True
[task check] test_07: file /tmp/bird.tmp is readable by all
[task check] stdout match (r) <^^^ \S "r"\S\S "r"\S\S "r"\S\S $$> True
[task check] test_08: file /tmp/bird.tmp is writtable by all
[task check] stdout match (r) <^^^ \S  \S"w"\S  \S"w"\S \S"w"\S $$> True
[task check] test_09: command [echo hello; echo bird] has stdout
[task check] ["hello", "bird"]
[task check] stdout match (r) <hello> True
[task check] stdout match (r) <bird> True
[task check] test_10: command [raku --version] has exit code [0]
[task check] stdout match (r) <command [raku --version] exit code [0]> True
[task check] test_11: package(s) installed "nano"
[task check] stdout match (r) <package nano is installed> True
[task check] test_12: pip3 package(s) installed "PyYAML"
[task check] stdout match (r) <^^ 'PyYAML' \s+> True
[task check] test_13: file rules.raku is readable by all
[task check] stdout match (r) <^^^ \S "r"\S\S "r"\S\S "r"\S\S $$> True
[task check] test_14: package(s) installed "nano"
[task check] stdout match (r) <package nano is installed> True
[task check] test_15: file /tmp/creds.txt data not empty ["username=", "password="]
[task check] stdout match (r) <^^ '>>>'> True
[task check] <>>> username=[censored] is not empty> True
[task check] <>>> password=[censored] is not empty> True
[task check] verify host [localhost] end
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

## Hosts.raku

To define dynamic hosts configuration, use `hosts.raku`, this should
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

Ssh host. Optional, see also `hosts.raku`

* `--verbose`

Verbose mode. Not used now. Reserved for the future

# Examples

See:

* `rules.raku` file
* `rules/` folder

# Author

Alexey Melezhik

# See Also

* [Chef Inspec](https://www.inspec.io/)
* [Goss](https://github.com/aelsabbahy/goss)

# Thanks to

God Who inspires me in my life!
