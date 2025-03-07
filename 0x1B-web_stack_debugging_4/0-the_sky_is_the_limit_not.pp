# Update Nginx default configuration to increase the limit
exec { 'update-nginx-limit':
  command => '/usr/bin/env sed -i "s/15/2000/" /etc/default/nginx',
}

# Restart Nginx to apply changes
exec { 'restart-nginx-service':
  command => '/usr/bin/env service nginx restart',
  require => Exec['update-nginx-limit'], # Ensures the limit update happens first
}
