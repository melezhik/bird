# Bird DSL

DSL to describe Linux hosts states

## file-exists $file-path

File exists:

    file-exists "{%*ENV<HOME>}/.bashrc";

## file-has-line $path, @arrays-of-lines

A text file contains lines:

    file-has-line "{%*ENV<HOME>}/.bashrc", "EDITOR=nano", 'export SP6_REPO';

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

## command-has-stdoud $command, @arrays-of-lines

A command has lines in stdoud:

    command-has-stdoud "echo hello; echo bird", "hello", "bird";

## command-exit-code $command, $code

A command exists with an exit code:

    # make sure we have an unzip
    command-exit-code "unzip", 0;        
