bash "echo username=admin > /tmp/creds.txt";
bash "echo password=123 >> /tmp/creds.txt";
bash "echo password: >> /tmp/creds.txt";

file-data-not-empty "/tmp/creds.txt",
  "username=\\s*", "password=", "password:";

file-has-line "/tmp/creds.txt", "username", "password", "login";
