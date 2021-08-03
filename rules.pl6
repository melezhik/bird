directory-exists "{%*ENV<HOME>}";
file-exists "{%*ENV<HOME>}/.bashrc";
#directory-exists "{%*ENV<HOME>}/yyy";

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

package-not-installed "mc";
