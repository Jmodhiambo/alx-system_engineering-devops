# Increase file descriptor limits for the OS to prevent "Too many open files" errors
exec { 'update-limits-conf':
  command => '/usr/bin/env echo "* - nofile 65535" >> /etc/security/limits.conf',
  unless  => '/bin/grep -q "* - nofile 65535" /etc/security/limits.conf',
}

# Update PAM (Pluggable Authentication Module) configuration for limits
exec { 'update-pam-limits':
  command => '/usr/bin/env echo "session required pam_limits.so" >> /etc/pam.d/common-session',
  unless  => '/bin/grep -q "session required pam_limits.so" /etc/pam.d/common-session',
}

exec { 'update-pam-limits-noninteractive':
  command => '/usr/bin/env echo "session required pam_limits.so" >> /etc/pam.d/common-session-noninteractive',
  unless  => '/bin/grep -q "session required pam_limits.so" /etc/pam.d/common-session-noninteractive',
}

# Restart the system services to apply changes
exec { 'restart-services':
  command => '/usr/bin/env systemctl restart sshd',
  require => [Exec['update-limits-conf'], Exec['update-pam-limits'], Exec['update-pam-limits-noninteractive']],
}
