# Puppet manifest to install Nginx and configure as per requirements
node default {
    # Ensure the Nginx package is installed
    package { 'nginx':
        ensure => installed,
    }

    # Ensure Nginx service is running and enabled
    service { 'nginx':
        ensure => running,
        enable => true,
    }

    # Replace the default page with "Hello World!"
    file { '/var/www/html/index.nginx-debian.html':
        ensure  => file,
        content => "Hello World!\n",
        owner   => 'www-data',
        group   => 'www-data',
        mode    => '0644',
    }

    # Configure the Nginx default site to include 301 redirect
    file { '/etc/nginx/sites-available/default':
        ensure  => file,
        content => @("END"),
        server {
            listen 80 default_server;
            listen [::]:80 default_server;

            root /var/www/html;
            index index.html index.nginx-debian.html;

            server_name _;

            location / {
                try_files \$uri \$uri/ =404;
            }

            # 301 redirect for /redirect_me
            location = /redirect_me {
                return 301 https://www.youtube.com/watch?v=QH2-TGUlwu4;
            }
        }
        END
        notify  => Service['nginx'],
    }

    # Validate Nginx configuration
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
