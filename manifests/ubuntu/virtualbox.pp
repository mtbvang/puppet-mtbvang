class mtbvang::ubuntu::virtualbox ($packageName = "virtualbox-4.3") {
  apt::source { virtualbox:
    location    => 'http://download.virtualbox.org/virtualbox/debian',
    release     => 'trusty',
    repos       => 'contrib non-free',
    key         => '98AB5139',
    key_source  => "http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc",
    include_src => false,
  }

  package { virtualbox:
    name   => $packageName,
    ensure => present,
  }
}