source "http://rubygems.org"

group :test do
  gem "rake"
  gem "puppet", ENV['PUPPET_VERSION'] || '~> 3.7.0'
  gem "puppet-lint"
  gem "rspec-puppet", '~> 1.0.0'
  gem "puppet-syntax"
  gem "puppetlabs_spec_helper"
end

group :development do
  gem "travis"
  gem "travis-lint"
# gem "puppet-blacksmith"
  gem "guard-rake"
  gem "metadata-json-lint"
  gem "beaker", '~> 2.2.0'
  gem "beaker-rspec", '~> 5.0.0'
  gem "pry", '>= 0.10.1'
  gem "vagrant-wrapper", '~> 1.2.0'
  gem "beaker-librarian", '>= 0.0.1'
end
