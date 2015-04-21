require 'spec_helper_acceptance'

describe 'mtbvang::ubuntu::vagrant class' do

  librarianVersion = '2.0.1'
  dockerVersion = '1.4.0'
  vagrantVersion = '1.7.2'

  context 'default parameters' do
    it 'should work with no errors' do
      pp = <<-EOS
        Exec {
          path => ["/bin/", "/sbin/", "/usr/bin/", "/usr/sbin/", "/usr/local/bin"] }
        class { 'mtbvang::ubuntu::vagrant': 
          user     => 'root',
          userHome => '/root',
          downloadUrl => "https://dl.bintray.com/mitchellh/vagrant/vagrant_#{vagrantVersion}_x86_64.deb"
        } 
      
      EOS

      # Run it twice and test for idempotency
      expect(apply_manifest(pp).exit_code).to_not eq(1)
      expect(apply_manifest(pp).exit_code).to eq(0)
    end

    describe command('vagrant -v') do
      its(:stdout) { should match(/Vagrant #{vagrantVersion}/) }
    end

  end
end
