# Bird DSL

DSL to describe Linux hosts states

## file-exists $file-path

File exists:

    file-exists "{%*ENV<HOME>}/.bashrc";

## file-has-line $path, @arrays-of-lines

A text file contains lines:

    file-has-line "{%*ENV<HOME>}/.bashrc", "EDITOR=nano", 'export SP6_REPO';

One could use Raku regular expressions as well, just prepend with `regexp:`

    file-has-line 
      "{%*ENV<HOME>}/.bashrc",;
      "regexp: 'EDITOR=' nano || vim"

##  file-data-not-empty $path, @patterns

A text file contains none empty data:
  
    # both `username:`, `password:` chunks should be none empty
    file-data-not-empty "~/creds.yaml", "password:", "username:";

Patterns should be Perl5 regexps. For example:

    # password is set as password = value, or as password=value or
    # password:value or as password : value or as password :value
 
    'password:\s*', 'password\s*=\s*'

## file-has-permission $file-path, %permissions-hash

File has permissions.

Permissions hash:

* `read-all`
* `write-all`
* `execute-all`

File is read by all:

    file-has-permission "{%*ENV<HOME>}/.bashrc", %( read-all => True )

## directory-exists $dir-path

Directory exists:

    directory-exists "{%*ENV<HOME>}/.sparrow6";

## package-installed $package-name | @package-names

Packages are installed:

    package-installed "python36"; # as a string

    package-installed(["perl", "rakudo-pkg"]); # as a list

## package-not-installed $package-name | @package-names

Package is not installed:

    package-not-installed "ruby";

## pip3-package-installed $package-name | @package-names

Packages are installed:

    pip3-package-installed "python-openstackclient"; # as a string

    pip3-package-installed(["python-openstackclient","openstacksdk"]); # as a list

## command-has-stdout $command, @arrays-of-lines

A command has lines in stdout:

    command-has-stdout "echo hello; echo bird", "hello", "bird";

## command-exit-code $command, $code

A command exists with an exit code:

    # make sure we have an unzip
    command-exit-code "unzip", 0;        

## service-is-running $srv

A service is running:

    # check if nginx service is running
    service-is-running "nginx";

## service-is-enabled $srv

A service is enabled:

    # check if nginx service is enabled
    service-is-enabled "nginx";

## k8s-deployment-has ($dpl,$namespace,$cnt,%config)

Checks k8s deployment:

    my %data = task-run "dpl check", "k8s-deployment-check" %(
      namespace => "pets",
      cat => %(
        command => "/usr/bin/cat",
        args => [
          "eat", "milk", "fish" 
        ],
        env => {
          "ENABLE_LOGGING" => "false",
        }
        volume-mounts => {
          foo-bar => "/opt/foo/bar",
        }
      )
    );

### Parameters

#### dpl

K8s deployment name. Required.

#### namespace

K8s namespace name. Required.

#### cnt

K8s container name. Required.

#### config

Raku hash. Sets k8s resource attributes to check. 

Following are config hash keys:

* volume-mounts

Array|Hash. List of mounted volumes in a format

Array:

    "name mountpath"

Hash:

    name => mountpath

For subPath use following notation:

Array:

    "name mountpath@subpath"

Hash:

    name => mountpath@subpath

* env

Array. List of environment variables in a format:

    ['env1', 'env2', 'env3' ]

* command

Array|Str. Docker command

* command-args

Array|Str. Docker command arguments
