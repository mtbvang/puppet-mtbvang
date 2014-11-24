require 'spec_helper'

describe 'mtbvang' do
  context 'supported operating systems' do
    ['Debian', 'RedHat'].each do |osfamily|
      describe "mtbvang class without any parameters on #{osfamily}" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => osfamily,
        }}

        it { should compile.with_all_deps }

        it { should contain_class('mtbvang::params') }
        it { should contain_class('mtbvang::install').that_comes_before('mtbvang::config') }
        it { should contain_class('mtbvang::config') }
        it { should contain_class('mtbvang::service').that_subscribes_to('mtbvang::config') }

        it { should contain_service('mtbvang') }
        it { should contain_package('mtbvang').with_ensure('present') }
      end
    end
  end

  context 'unsupported operating system' do
    describe 'mtbvang class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { should contain_package('mtbvang') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
