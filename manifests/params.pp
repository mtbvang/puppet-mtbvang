# == Class mtbvang::params
#
# This class is meant to be called from mtbvang
# It sets variables according to platform
#
class mtbvang::params {
  case $::osfamily {
    'Debian'           : { }
    'RedHat', 'Amazon' : { }
    default            : { fail("${::operatingsystem} not supported") }
  }
}
