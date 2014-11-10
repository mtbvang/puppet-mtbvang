# == Class: common
#
# Full description of class common here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class common (
  $package_name = $::common::params::package_name,
  $service_name = $::common::params::service_name,
) inherits ::common::params {

  # validate parameters here

  class { '::common::install': } ->
  class { '::common::config': } ~>
  class { '::common::service': } ->
  Class['::common']
}
