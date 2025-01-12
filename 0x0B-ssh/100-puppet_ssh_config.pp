# Client configuration file

file { '/home/ubuntu/.ssh/config':
  ensure  => file,
  owner   => 'ubuntu',
  group   => 'ubuntu',
  mode    => '0600',
  content => "Host *\n  IdentityFile ~/.ssh/school\n  PasswordAuthentication no\n",
  # You can add a condition to avoid redeclaration
  onlyif  => 'test ! -f /home/ubuntu/.ssh/config',
}
