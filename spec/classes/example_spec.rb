require 'spec_helper'

describe 'common' do
  context 'supported operating systems' do
    ['Debian', 'RedHat'].each do |osfamily|
      describe "common class without any parameters on #{osfamily}" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => osfamily,
        }}

        it { should compile.with_all_deps }

        it { should contain_class('common::params') }
        it { should contain_class('common::install').that_comes_before('common::config') }
        it { should contain_class('common::config') }
        it { should contain_class('common::service').that_subscribes_to('common::config') }

        it { should contain_service('common') }
        it { should contain_package('common').with_ensure('present') }
      end
    end
  end

  context 'unsupported operating system' do
    describe 'common class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { should contain_package('common') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
