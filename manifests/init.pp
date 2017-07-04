class fail2ban {
  package { 'fail2ban':
    ensure => 'latest';
  }
  package { 'fail2ban-systemd':
    ensure => 'latest';
  }

  package { 'fail2ban-firewalld':
    ensure => 'latest';
  }

  package { 'fail2ban-server':
    ensure => 'latest';
  }

  service { 'fail2ban':
    ensure => 'running';
  }

  service { 'firewalld':
    ensure => 'running';
  }

  $services = [fail2ban,firewalld]

  file { '/etc/fail2ban/jail.d/00-firewalld.conf':
    mode   => '0644',
    source => [
      'puppet:///modules/fail2ban/00-firewalld.conf'
    ]
  } -> Service[$services] 

  file { '/etc/fail2ban/jail.conf':
    mode   => '0644',
    source => [
      "puppet:///modules/fail2ban/conf.${host}",
      "puppet:///modules/fail2ban/conf.${operatingsystem}",
      'puppet:///modules/fail2ban/jail.conf'
    ]
  } ~> Service[$services]
}
