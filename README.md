# Bird

Perl6 alternative to Chef Inspec

# Usage

Define rules:

**rules.pl6**

    file-exists "/home/bird/list.txt";
    file-has-line "/home/bird/list.txt", "sparrow", "crow";
    file-has-permission "/home/bird/list.txt", %( read-all => true, write-all => true );

Run checks

  bird --host=192.168.0.1 --user=alex --password=PasSword!


# Rules DSL

## file-exists $file-path

## file-has-line @arrays-of-lines

## file-has-permission $file-path, %permissions-hash

Permissions hash:

* `read-all`
* `write-all`
* `execute-all`

## package-is-installed $package-name

## directory-exists $dir-path

# Ssh hosts

There are two ways to set ssh hosts

## Command line

By using `--host`, `--user`, `--password` options:

    bird --host=192.168.0.1 --user=alex --password=PasSword


## Hosts.pl6

To define dynamic hosts configuration, use `hosts.pl6`, this should
be Perl6 script that returns `@Array` object with following structure:

    [
      %( 
          ip => $host-ip-address # Host Ip Address
          user => $user # Ssh user, optional
          password => $password # Ssh password, optional
      ),
      %(
          # next host
      )
    ]
  
For example:

    my %state = task-run "worker nodes", "ambari-hosts", %(
      ambari_host  => 'cluster.fqdn.host',
      admin => 'super-jack',
      password => 'PaSsWord123',
      cluster => "cluster01",
      node_type => "worker",
    );
    

    %state<hosts><>.map: { my %i = $_; %i<user> = 'ssh-admin', %i<password> = 'SshPassword'  }

You can omit `user` and `password` in hosts `@Array`, setting them from command line:

    bird --user=alex --password=PasSword


# Author

Alexey Melezhik

# See Also

[Chef Inspec](https://www.inspec.io/)
