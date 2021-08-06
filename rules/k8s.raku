k8s-deployment-has "nginx-deployment", "melezhik-sandbox", "nginx", %(
  env => ['DEMO_GREETING'],
  volume-mounts => %(
    www-data => "/var/www",
  ),
);


