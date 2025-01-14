# Puppet manifest to install and configure Nginx with the specified requirements

node default {
    # Ensure Nginx package is installed
    package { 'nginx':
        ensure => installed,
    }

    # Ensure Nginx service is running and enabled
    service { 'nginx':
        ensure    => running,
        enable    => true,
        subscribe => File['/etc/nginx/sites-available/default'],
    }

    # Configure the Nginx default site
    file { '/etc/nginx/sites-available/default':
        ensure  => file,
        content => template('nginx/default.erb'),
        notify  => Service['nginx'],
    }

    # Replace the default Nginx page with "Hello World!"
    file { '/var/www/html/index.nginx-debian.html':
        ensure  => file,
        content => "Hello World!\n",
        owner   => 'www-data',
        group   => 'www-data',
        mode    => '0644',
    }

    # Ensure the /redirect_me route performs a 301 redirect
    file { '/etc/nginx/sites-available/default':
        ensure  => file,
        content => template('nginx/default_redirect.erb'),
        notify  => Service['nginx'],
    }

    # Ensure Nginx configuration is valid
    exec { 'nginx -t':
        command     => '/usr/sbin/nginx -t',
        refreshonly => true,
        subscribe   => File['/etc/nginx/sites-available/default'],
    }

    # Restart Nginx to apply changes
    exec { 'restart_nginx':
        command     => '/usr/sbin/service nginx restart',
        refreshonly => true,
        subscribe   => Exec['nginx -t'],
    }
}
