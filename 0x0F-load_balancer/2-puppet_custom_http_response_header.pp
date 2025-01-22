# Puppet manifest to configure Nginx with a custom HTTP header X-Served-By

# Update the server before possible installations
exec { 'update server':
  command  => 'apt-get update',
  user     => 'root',
  provider => 'shell',
}

# Install Nginx package if not already installed
package { 'nginx':
  ensure   => present,
  provider => 'apt'
}

# Define the custom HTTP header to be added
file_line { 'add HTTP header':
  ensure => 'present',
  path   => '/etc/nginx/sites-available/default',
  after  => 'listen 80 default_server;',
  line   => 'add_header X-Served-By $hostname;'
}

# Ensure Nginx service is running
service { 'nginx':
  ensure  => 'running',
  enable  => true,
  require => Package['nginx']
}
