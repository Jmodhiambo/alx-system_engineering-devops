# Puppet manifest to configure Nginx with a custom HTTP header X-Served-By

# Install Nginx package if not already installed
package { 'nginx':
  ensure => installed,
}

# Define the custom HTTP header to be added
file { '/etc/nginx/conf.d/custom_header.conf':
  ensure  => file,
  content => "add_header X-Served-By \"$(hostname)\";\n",
  notify  => Service['nginx'], # Notify Nginx to restart after modification
}

# Ensure Nginx service is running
service { 'nginx':
  ensure    => running,
  enable    => true,
  subscribe => File['/etc/nginx/conf.d/custom_header.conf'], # Restart Nginx if the config file changes
}
