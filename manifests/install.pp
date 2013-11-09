# == Class sshkey_utilities::intall
#
class sshkey_utilities::install {
  include sshkey_utilities::params

  package { $sshkey_utilities::params::package_name:
    ensure => present,
  }
}
