# Ensure Nginx is installed
package { 'nginx':
  ensure => installed,
}

# Ensure Nginx service is running
service { 'nginx':
  ensure  => running,
  enable  => true,
  require => Package['nginx'],
}

# Fix configuration settings for optimal performance, with proper ownership and permissions
file { '/etc/nginx/nginx.conf':
  ensure  => file,
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
  content => template('path_to_your_nginx_template.erb'),
  require => Package['nginx'],
  notify  => Service['nginx'],
}

# Reload Nginx to apply changes
exec { 'reload-nginx':
  command     => '/usr/sbin/nginx -s reload',
  refreshonly => true,
  subscribe   => File['/etc/nginx/nginx.conf'],
}

# Example for log monitoring (e.g., configuring log rotation for Nginx logs)
file { '/etc/logrotate.d/nginx':
  ensure  => file,
  content => template('path_to_your_logrotate_template.erb'),
  require => Package['nginx'],
}
