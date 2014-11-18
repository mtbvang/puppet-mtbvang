# == Class common::params
#
# This class is meant to be called from common
# It sets variables according to platform
#
class common::params {
  case $::osfamily {
    'Debian'           : { }
    'RedHat', 'Amazon' : { }
    default            : { fail("${::operatingsystem} not supported") }
  }
}
