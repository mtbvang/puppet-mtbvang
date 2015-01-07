class mtbvang::ubuntu::virtualbox ($packageName = "virtualbox-4.3") {
  package { virtualbox:
    name   => $packageName,
    ensure => present,
  }
}