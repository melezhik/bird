# Bird DSL

DSL to describe Linux hosts states

## file-exists $file-path

## file-has-line @arrays-of-lines

## file-has-permission $file-path, %permissions-hash

Permissions hash:

* `read-all`
* `write-all`
* `execute-all`

## package-is-installed $package-name

## directory-exists $dir-path

