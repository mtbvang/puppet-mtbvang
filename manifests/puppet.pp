define mtbvang::puppet::librarianpuppet () {
  exec { 'librarianPuppet':
    command   => $mtbvang::params::librarianPuppetInstallCmd,
    logoutput => on_failure,
    creates   => $mtbvang::params::librarianPuppetExec,
    unless    => $mtbvang::params::librarianPuppetUnless,
  }
}

class mtbvang::puppet::beaker {
  $beakerPkgs = "make ruby-dev libxml2-dev libxslt1-dev g++"

  package { $beakerPkgs: ensure => 'installed' } ->
  package { 'beaker':
    ensure   => 'installed',
    provider => 'gem',
  }
}

class mtbvang::puppet ($puppetPackageName = $mtbvang::params::puppetPackageName, $puppetVersion = $mtbvang::params::puppetVersion) {
  ::wget::fetch { "fetchPuppet":
    before      => Package['puppetcommon', 'puppet'],
    source      => "https://apt.puppetlabs.com/${puppetPackageName}",
    destination => "/tmp/${puppetPackageName}",
    timeout     => 120,
    chmod       => 0755,
  }

  package { "puppetcommon":
    name     => 'puppet-common',
    ensure   => $puppetVersion,
    provider => apt,
    source   => "/tmp/${puppetPackageName}",
  }

  package { "puppet":
    name     => 'puppet',
    ensure   => $puppetVersion,
    provider => apt,
    source   => "/tmp/${puppetPackageName}",
  }

}