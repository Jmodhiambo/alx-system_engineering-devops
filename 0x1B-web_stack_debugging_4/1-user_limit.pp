# Increase file descriptor limits for holberton user

file { '/etc/security/limits.d/holberton.conf':
    ensure  => file,
    content => @("EOT")
      holberton hard nofile 65535
      holberton soft nofile 65535
    |-EOT-|
}

exec { 'update-pam-limits':
    command => '/usr/bin/env bash -c "echo session required pam_limits.so >> /etc/pam.d/common-session"',
    unless  => '/bin/grep -q "pam_limits.so" /etc/pam.d/common-session',
}
