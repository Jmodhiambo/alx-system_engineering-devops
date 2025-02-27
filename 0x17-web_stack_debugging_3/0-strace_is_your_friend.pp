# Puppet manifest to fix Apache 500 errors by installing necessary PHP modules and correcting WordPress file permissions

# Ensure PHP and MySQL modules are installed
package { ['php', 'php-mysql', 'libapache2-mod-php']:
    ensure => installed,
}

# Fix permissions for the WordPress directory
file { '/var/www/html':
    ensure  => directory,
    recurse => true,
    owner   => 'www-data',
    group   => 'www-data',
    mode    => '0755',
}

# Restart Apache to apply changes
exec { 'restart_apache':
    command     => '/etc/init.d/apache2 restart',
    refreshonly => true,
}
