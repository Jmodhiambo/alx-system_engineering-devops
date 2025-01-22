# Puppet manifest to configure Nginx with a custom HTTP header X-Served-By

# Update the Ubuntu server
exec { 'update server':
  command  => '/usr/bin/apt-get update -y',
  user     => 'root',
  provider => 'shell',
}
->

# Install Nginx web server
package { 'nginx':
  ensure   => present,
  provider => 'apt',
}
->

# Add custom HTTP header (X-Served-By: hostname) to Nginx configuration
file_line { 'add HTTP header':
  ensure => present,
  path   => '/etc/nginx/sites-available/default',
  after  => 'listen 80 default_server;',
  line   => 'add_header X-Served-By $hostname;',
}
->

# Start and enable Nginx service
service { 'nginx':
  ensure  => running,
  enable  => true,
  require => Package['nginx'],
}
