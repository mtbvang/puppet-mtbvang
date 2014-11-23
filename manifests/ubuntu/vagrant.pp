#
# Install vagrant and plugins.
#
class common::ubuntu::vagrant (
  $downloadUrl = "https://dl.bintray.com/mitchellh/vagrant/vagrant_1.6.3_x86_64.deb",
  $user        = 'dev',
  $userHome    = '/home/dev',
  $plugins     = [
    'vagrant-hosts,2.1.5',
    'vagrant-vbguest,0.10.0',
    'vagrant-hostsupdater,0.0.11',
    'vagrant-cachier,1.1.0']) {
  $downloadFile = '/tmp/vagrant.deb'

  ::wget::fetch { "fetchVagrant":
    before      => Package['vagrant'],
    source      => $downloadUrl,
    destination => $downloadFile,
    chmod       => 0755,
  }

  $vagrantRequiredPkgs = ['libxslt-dev', 'libxml2-dev', 'build-essential']

  package { $vagrantRequiredPkgs: ensure => installed }

  exec { 'removeOldVagrant':
    command   => "apt-get -y remove vagrant",
    logoutput => on_failure,
    creates   => $downloadFile,
    user      => 'root',
  }

  package { "vagrant":
    require  => [Package[$vagrantRequiredPkgs], Exec['removeOldVagrant']],
    ensure   => installed,
    provider => dpkg,
    source   => $downloadFile,
  }

  common::ubuntu::vagrant::plugin { $plugins:
    before   => File["${userHome}/.vagrant.d"],
    require  => [Package['vagrant']],
    user     => $user,
    userHome => $userHome,
  }

  file { "${userHome}/.vagrant.d":
    require => Package['vagrant'],
    ensure  => 'directory',
    owner   => $user,
    group   => $user,
    recurse => true,
  }
}

define common::ubuntu::vagrant::plugin ($user = 'dev', $userHome = '/home/dev',) {
  $plugin = split($name, ',')

  exec { "${plugin[0]}-plugin":
    environment => "HOME=${userHome}",
    command     => "/usr/bin/vagrant plugin install ${plugin[0]} --plugin-version ${plugin[1]}",
    logoutput   => on_failure,
    unless      => "vagrant plugin list | grep '${plugin[0]} (${plugin[1]})'",
    user        => $user,
  }
