require "spec_helper"

describe Facter::Util::Fact do
  before {
    Facter.clear
  }

  describe "git_html_path" do
    subject { Facter.fact(:git_html_path).value }

    context 'windows' do
      it do
        allow(Facter).to receive('value').with(:osfamily).and_return('windows')
        allow(Facter::Util::Resolution).to receive('exec').with("git --html-path 2>nul").and_return('windows_path_change')
        is_expected.to eq('windows_path_change')
      end
    end

    context 'non-windows' do
      it do
        allow(Facter).to receive('value').with(:osfamily).and_return('RedHat')
        allow(Facter::Util::Resolution).to receive('exec').with("git --html-path 2>/dev/null").and_return('/usr/share/doc/git-1.7.1')
        is_expected.to eq('/usr/share/doc/git-1.7.1')
      end
    end

  end
end