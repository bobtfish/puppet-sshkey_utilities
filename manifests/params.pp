# == Class sshkey_utilities::params
#
# This class is meant to be called from sshkey_utilities
# It sets variables according to platform
#
class sshkey_utilities::params {
  case $::osfamily {
    'Debian': {
      $package_name = 'sshkey_utilities'
      $service_name = 'sshkey_utilities'
    }
    'RedHat', 'Amazon': {
      $package_name = 'sshkey_utilities'
      $service_name = 'sshkey_utilities'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
