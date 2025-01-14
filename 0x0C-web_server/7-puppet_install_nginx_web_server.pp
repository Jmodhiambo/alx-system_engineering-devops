# Install the Nginx package

package { 'nginx':
  ensure => 'installed',
}

# Create the "Hello World!" page
file { '/var/www/html/index.html':
  ensure  => 'file',
  content => 'Hello World!',
}

# Configure Nginx to listen on port 80 and set up the 301 redirect
file { '/etc/nginx/sites-available/default':
  ensure  => 'file',
  content => '
server {
    listen 80 default_server;
    listen [::]:80 default_server;

    root /var/www/html;
    index index.html;

    server_name _;

    location / {
        try_files $uri $uri/ =404;
    }

    location = /redirect_me {
        return 301 https://www.youtube.com/watch?v=QH2-TGUlwu4;
    }
}
',
  notify  => Service['nginx'],  # Restart Nginx if this file is changed
}

# Ensure Nginx is running
service { 'nginx':
  ensure  => 'running',
  enable  => true,
  require => Package['nginx'],
}
