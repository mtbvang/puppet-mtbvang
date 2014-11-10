# == Class common::params
#
# This class is meant to be called from common
# It sets variables according to platform
#
class common::params {
  case $::osfamily {
    'Debian': {
      $package_name = 'common'
      $service_name = 'common'
    }
    'RedHat', 'Amazon': {
      $package_name = 'common'
      $service_name = 'common'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
