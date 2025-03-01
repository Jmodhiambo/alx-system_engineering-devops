# Puppet manifest to fix Apache 500 errors by installing necessary PHP modules and correcting WordPress file permissions

exec { 'fix-wordpress':
        command => 'sed -i s/phpp/php/g /var/www/html/wp-settings.php',
        path    => ['/bin', '/usr/bin/', '/usr/loca/bin/'],
}

# Ensure PHP and necessary modules are installed
package { 'php':
        ensure => present,
}

package { 'libapache2-mod-php':
        ensure  => present,
        require => Package['php'],
}

package { 'php-mysql':
        ensure  => present,
        require => Package['php'],
}

# Run apt-get update to resolve package location issues
exec { 'apt-update':
        command => '/usr/bin/apt-get update',
        path    => ['/bin', '/usr/bin/', '/usr/local/bin/'],
        before  => Package['php'],
}
