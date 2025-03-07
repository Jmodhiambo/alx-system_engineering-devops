# Fix open files limit
exec { 'Fix hard and soft limits':
    command => '/usr/bin/env sed -i "s/4/20000/; s/5/20000/" /etc/security/limits.conf',
}

# Enable PAM limits without visible output
exec { 'Enable PAM limits':
    command => '/bin/sh -c "echo \'session required pam_limits.so\' >> /etc/pam.d/common-session"',
    unless  => '/bin/grep -q "pam_limits.so" /etc/pam.d/common-session"',
}
