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

# Fix configuration settings for optimal performance
file { '/etc/nginx/nginx.conf':
  ensure  => file,
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
