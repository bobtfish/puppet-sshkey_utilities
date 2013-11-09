# == Class sshkey_utilities::service
#
# This class is meant to be called from sshkey_utilities
# It ensure the service is running
#
class sshkey_utilities::service {
  include sshkey_utilities::params

  service { $sshkey_utilities::params::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
