directory-exists "{%*ENV<HOME>}";
file-exists "{%*ENV<HOME>}/.bashrc";
#directory-exists "{%*ENV<HOME>}/yyy";
#file-has-line "{%*ENV<HOME>}/.bashrc", "EDITOR=nano", "DICTIONARY=en_US";
file-has-permission "documentation/dsl.md", %( read-all => True )
