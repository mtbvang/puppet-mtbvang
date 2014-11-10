# == Class common::service
#
# This class is meant to be called from common
# It ensure the service is running
#
class common::service {

  service { $::common::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
