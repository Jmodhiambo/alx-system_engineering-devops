ure Nginx service is running
    service { 'nginx':
        ensure     => running,
        enable     => true,
        hasrestart => true,
    }

    # Configure Nginx to handle high traffic
    file { '/etc/nginx/nginx.conf':
        ensure  => file,
        content => template('nginx/nginx.conf.erb'),
        notify  => Service['nginx'],
    }

    # Set optimized Nginx configuration
    file { '/etc/nginx/conf.d/optimization.conf':
        ensure  => file,
        content => """
        worker_processes auto;
        events {
            worker_connections 4096;
            multi_accept on;
        }
        http {
            keepalive_timeout 65;
            client_max_body_size 10m;
            client_body_buffer_size 16k;
            proxy_buffers 16 16k;
            proxy_buffer_size 16k;
            proxy_busy_buffers_size 64k;
        }
        """,
        notify  => Service['nginx'],
    }

    # Reload Nginx to apply changes
    exec { 'reload-nginx':
        command     => '/etc/init.d/nginx reload',
        refreshonly => true,
        subscribe   => File['/etc/nginx/conf.d/optimization.conf'],
    }
