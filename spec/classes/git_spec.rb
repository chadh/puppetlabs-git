require 'spec_helper'

describe 'git' do
  context 'defaults' do
    it { is_expected.to contain_package('git') }
  end

  context 'with package_manage set to false' do
    let(:params) { { package_manage: false } }

    it { is_expected.not_to contain_package('git') }
  end

  context 'with a custom git package name' do
    let(:params) { { package_name: 'gitolite' } }

    it { is_expected.to contain_package('gitolite') }
  end

  context 'with package_ensure => latest' do
    let(:params) { { package_ensure: 'latest' } }

    it { is_expected.to contain_package('git').with('ensure' => 'latest') }
  end

  context 'with configs' do
    let(:params) do
      {
        configs: {
          'user.name' => { value: 'test' },
          'user.email' => 'test@example.com',
        },
      }
    end

    it { is_expected.to contain_git__config('user.name') }
    it { is_expected.to contain_git__config('user.email') }
  end

  context 'with configs and configs defaults' do
    let(:params) do
      {
        configs: {
          'core.filemode' => false,
        },
        configs_defaults: {
          'scope' => 'system',
        },
      }
    end

    it do
      is_expected.to contain_git__config('core.filemode').with(
        'value' => false,
        'scope' => 'system',
      )
    end
  end
end
