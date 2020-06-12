require 'spec_helper'

describe 'git::config', type: :define do
  context 'has working default parameters' do
    let(:title) { 'user.name' }
    let(:params) do
      {
        value: 'JC Denton',
      }
    end

    it do
      is_expected.to contain_git_config('user.name').with(
        value: 'JC Denton',
        key: 'user.name',
        user: 'root',
      )
      have_git_config_resource_count(1)
    end
  end

  context 'allows you to change user' do
    let(:title) { 'user.email' }
    let(:params) do
      {
        value: 'jcdenton@UNATCO.com',
        user: 'admin',
      }
    end

    it do
      is_expected.to contain_git_config('user.email').with(
        value: 'jcdenton@UNATCO.com',
        key: 'user.email',
        user: 'admin',
      )
      have_git_config_resource_count(1)
    end
  end

  context 'allow boolean values' do
    let(:title) { 'core.preloadindex' }
    let(:params) do
      {
        value: true,
        scope: 'system',
      }
    end

    it { is_expected.to compile }

    it do
      is_expected.to contain_git_config(title).with(
        value: params[:value],
        scope: params[:scope],
      )
    end
  end
end
