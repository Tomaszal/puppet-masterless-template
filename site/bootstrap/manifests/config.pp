class bootstrap::config (
  String $control_remote = lookup('bootstrap::control_remote'),
) {

  # Git package

  package { 'git':
    ensure => 'present'
  }

  # r10k configuration

  file {
    '/etc/puppetlabs/r10k':
      ensure  => directory,;

    '/etc/puppetlabs/r10k/r10k.yaml':
      ensure  => file,
      content => template('bootstrap/r10k.yaml.erb'),;
  }

}
