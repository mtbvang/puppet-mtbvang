# == Class mtbvang::params
#
# This class is meant to be called from mtbvang
# It sets variables according to platform
#
class mtbvang::params {
  case $::osfamily {
    'Debian'           : {
      $librarianPuppetVersion = '1.3.2'
      $librarianPuppetInstallCmd = "sudo gem install librarian-puppet -v ${librarianPuppetVersion} --source 'https://rubygems.org'"
      $librarianPuppetExec = '/usr/local/bin/librarian-puppet'
      $librarianPuppetUnless = 'which librarian-puppet'

      case $::lsbdistcodename {
        'trusty'  : {
          $puppetPackageName = "puppetlabs-release-trusty.deb"
          $puppetVersion = '3.6.2-1puppetlabs1'
        }
        'precise' : {

        }
        default   : {
          fail("Unsupported Debian distribution: ${::lsbdistcodename}")
        }
      }
    }
    'RedHat', 'Amazon' : {
    }
    default            : {
      fail("${::operatingsystem} not supported")
    }
  }
}
