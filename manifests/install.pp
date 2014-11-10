# == Class common::install
#
class common::install {

  package { $::common::package_name:
    ensure => present,
  }
}
