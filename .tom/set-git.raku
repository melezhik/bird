#!perl6

task-run "set git", "git-base", %(
  email => 'melezhik@gmail.com',
  name  => 'Aleksey Melezhik',
  config_scope => 'local',
  set_credential_cache => 'on'
);
