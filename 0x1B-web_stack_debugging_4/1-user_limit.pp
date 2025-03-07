# Update open file limits for all users
exec { 'Fix open file limits':
  command => '/usr/bin/env sed -i "s/1024/20000/; s/4096/20000/" /etc/security/limits.conf',
}
