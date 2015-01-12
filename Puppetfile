#!/usr/bin/env ruby
#^syntax detection

forge "http://forge.puppetlabs.com"

mod 'leonardothibes/wget', '>= 1.0.4'
mod 'puppetlabs/apt', '>= 1.6.0'

# Updates to support upstart in docker. Tests need to be written before the pull request will be accepted. https://github.com/garethr/garethr-docker/pull/95
mod 'garethr/docker',
  :git => 'git://github.com/mtbvang/garethr-docker.git'
