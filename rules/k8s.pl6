k8s-deployment-has "nginx-deployment", "melezhik-sandbox", "nginx", %(
  volume-mounts => %(
    www-data => "/var/www"
  ),
  env => [ 'DEMO_GREETING' , 'DEMO_FAREWELL' ]
);
