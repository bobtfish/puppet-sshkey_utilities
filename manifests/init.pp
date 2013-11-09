# == Class: sshkey_utilities
#
# Full description of class sshkey_utilities here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class sshkey_utilities (
) inherits sshkey_utilities::params {

  # validate parameters here

  class { 'sshkey_utilities::install': } ->
  class { 'sshkey_utilities::config': } ~>
  class { 'sshkey_utilities::service': } ->
  Class['sshkey_utilities']
}
