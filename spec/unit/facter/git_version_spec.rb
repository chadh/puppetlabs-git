require "spec_helper"

describe Facter::Util::Fact do
  before {
    Facter.clear
  }

  describe "git_version" do
    subject { Facter.fact(:git_version).value }

    context 'vanilla git' do
      it do
        git_version_output = 'git version 2.1.2'
        allow(Facter::Util::Resolution).to receive('exec').with('git --version 2>&1').and_return(git_version_output)
        is_expected.to eq('2.1.2')
      end
    end

    context 'git with hub' do
      it do
        git_version_output = <<-EOS
git version 2.1.2
hub version 1.12.2
        EOS
        allow(Facter::Util::Resolution).to receive('exec').with('git --version 2>&1').and_return(git_version_output)
        is_expected.to eq('2.1.2')
      end
    end

    context 'no git present' do
      it do
        allow(Facter::Util::Resolution).to receive('which').with('git').and_return(false)
        is_expected.to be_nil
      end
    end
  end
end
