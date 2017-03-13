class fail2ban {
  package { 'fail2ban':
    ensure => 'latest';
  }
  service { 'fail2ban':
    ensure => 'running';
  }
  file { '/etc/fail2ban/jail.conf':
    mode   => '0644',
    source => [
      "puppet:///modules/nfs/conf.${host}",
      "puppet:///modules/nfs/conf.${operatingsystem}",
      'puppet:///modules/fail2ban/jail.conf'
    ]
  }
}
