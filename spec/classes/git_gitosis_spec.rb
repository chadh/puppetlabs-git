require 'spec_helper'

describe 'git::gitosis' do
  context 'defaults' do
    it { is_expected.to contain_package('gitosis') }
    it { is_expected.to contain_class('git') }
    it { is_expected.to create_class('git::gitosis') }
  end
end
