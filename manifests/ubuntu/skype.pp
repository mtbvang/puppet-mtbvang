class common::ubuntu::skype ($ensure = 'latest') {
  include apt

  apt::source { 'canonicalArhive':
    location    => 'http://archive.canonical.com/',
    repos       => 'partner',
    include_src => false
  } ->
  exec { 'enablei386Architecture':
    user      => root,
    command   => "dpkg --add-architecture i386; apt-get update",
    onlyif    => "dpkg --print-foreign-architectures",
    logoutput => on_failure
  } ->
  package { 'skype': ensure => $ensure }
}