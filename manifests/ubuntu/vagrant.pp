#
# Install vagrant and plugins.
#
class common::ubuntu::vagrant (
  $downloadUrl              = "https://dl.bintray.com/mitchellh/vagrant/vagrant_1.6.3_x86_64.deb",
  $user                     = 'dev',
  $userHome                 = '/home/dev',
  $hostPluginVersion        = '2.1.5',
  $vbguestPluginVersion     = '0.10.0',
  $hostsupdatePluginVersion = '0.0.11',
  $cachierPluginVersion     = '1.1.0') {
  ::wget::fetch { "fetchVagrant":
    before      => Package['vagrant'],
    source      => $downloadUrl,
    destination => "/tmp/vagrant.deb",
    chmod       => 0755,
  }

  $vagrantRequiredPkgs = ['libxslt-dev', 'libxml2-dev', 'build-essential']

  package { $vagrantRequiredPkgs: ensure => installed }

  package { "vagrant":
    require  => Package[$vagrantRequiredPkgs],
    ensure   => installed,
    provider => dpkg,
    source   => "/tmp/vagrant.deb",
  }

  exec { 'vagrant_hosts_plugin':
    environment => "HOME=${userHome}",
    command     => "/usr/bin/vagrant plugin install vagrant-hosts --plugin-version ${hostPluginVersion}",
    require     => [Package['vagrant']],
    before      => File["${userHome}/.vagrant.d"],
    logoutput   => on_failure,
    unless      => "vagrant plugin list | grep 'vagrant-hosts (${hostPluginVersion})'",
    user        => $user,
  }

  exec { 'vagrant_vbguest_plugin':
    environment => "HOME=${userHome}",
    command     => "/usr/bin/vagrant plugin install vagrant-vbguest --plugin-version ${vbguestPluginVersion}",
    require     => [Package['vagrant']],
    before      => File["${userHome}/.vagrant.d"],
    logoutput   => on_failure,
    unless      => "vagrant plugin list | grep 'vagrant-vbguest (${vbguestPluginVersion})'",
    user        => $user,
  }

  exec { 'vagrant_hostsupdater_plugin':
    environment => "HOME=${userHome}",
    command     => "/usr/bin/vagrant plugin install vagrant-hostsupdater --plugin-version ${hostsupdatePluginVersion}",
    require     => [Package['vagrant']],
    before      => File["${userHome}/.vagrant.d"],
    logoutput   => on_failure,
    unless      => "vagrant plugin list | grep 'vagrant-hostsupdater (${hostsupdatePluginVersion})'",
    user        => $user,
  }

  exec { 'vagrant_cachier_plugin':
    environment => "HOME=${userHome}",
    command     => "/usr/bin/vagrant plugin install vagrant-cachier --plugin-version ${cachierPluginVersion}",
    require     => [Package['vagrant']],
    before      => File["${userHome}/.vagrant.d"],
    logoutput   => on_failure,
    unless      => "vagrant plugin list | grep 'vagrant-cachier (${cachierPluginVersion})'",
    user        => $user,
  }

  file { "${userHome}/.vagrant.d":
    require => Package['vagrant'],
    ensure  => 'directory',
    owner   => $user,
    group   => $user,
    # mode    => '0755',
    recurse => true,
  }

}