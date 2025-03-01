# Puppet manifest to fix Apache 500 errors by installing necessary PHP modules and correcting WordPress file permissions

# Remove duplicate sources and update apt
exec { 'fix-wordpress':
    command => 'sed -i s/phpp/php/g /var/www/html/wp-settings.php',
    path    => ['/bin', '/usr/bin/', '/usr/loca/bin/'], 
}
