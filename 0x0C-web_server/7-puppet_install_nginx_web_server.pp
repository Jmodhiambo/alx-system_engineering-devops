# Install Nginx package

package { 'nginx':
  ensure => 'installed',
}

# Replace the default page with "Hello World!"
file { '/var/www/html/index.html':
  ensure  => 'file',
  content => 'Hello World',
}

# Configure Nginx server to redirect /redirect_me with a 301 Moved Permanently
file { '/etc/nginx/sites-available/default':
  ensure  => 'file',
  content => template('nginx/default_redirect.pp.erb'),  # Use template to include the proper server configuration
  notify  => Service['nginx'],  # Notify service to restart if the file changes
}

# Ensure Nginx service is running
service { 'nginx':
  ensure  => 'running',
  enable  => true,
  require => Package['nginx'],
}
