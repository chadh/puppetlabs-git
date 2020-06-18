require 'spec_helper'

describe 'git_exec_path' do
  before(:each) { Facter.clear }
  subject { Facter.fact(:git_exec_path).value }

  context 'windows' do
    it do
      allow(Facter).to receive('value').with(:osfamily).and_return('windows')
      allow(Facter::Util::Resolution).to receive('exec').with('git --exec-path 2>nul').and_return('windows_path_change')
      is_expected.to eq('windows_path_change')
    end
  end

  context 'non-windows' do
    it do
      allow(Facter).to receive('value').with(:osfamily).and_return('RedHat')
      allow(Facter::Util::Resolution).to receive('exec').with('git --exec-path 2>/dev/null').and_return('/usr/libexec/git-core')
      is_expected.to eq('/usr/libexec/git-core')
    end
  end
end
