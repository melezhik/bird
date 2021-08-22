bash "echo username=admin > /tmp/creds.txt", %(
  description => "set username"
);

bash "echo password=123 >> /tmp/creds.txt", %(
  description => "set password"
);

bash "echo password: >> /tmp/creds.txt", %(
  description => "set empty password"
);

file-data-not-empty "/tmp/creds.txt",
  "username=\\s*", "password=", "password:";

file-has-line "/tmp/creds.txt", "username", "password", "login";
