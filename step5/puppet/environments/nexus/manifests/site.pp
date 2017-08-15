node default {

  include role_nexus_server

}

class role_nexus_server {

  class { '::java':
    distribution => 'jre',
  }

  class { '::nexus':
    version    => '2.8.0',
    revision   => '05',
    nexus_root => '/srv', # All directories and files will be relative to this
  }

  Class['::java'] ->
  Class['::nexus']
}
