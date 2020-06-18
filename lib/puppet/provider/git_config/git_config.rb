require 'puppet/resource_api/simple_provider'
require 'etc'
require 'shellwords'

# @summary Provider for configuring git
class Puppet::Provider::GitConfig::GitConfig < Puppet::ResourceApi::SimpleProvider
  def get(_context, names)
    ret = []
    names.each do |resource|
      key = resource[:key]
      user = resource[:user]
      scope = resource[:scope]
      home = Etc.getpwnam(user)[:dir]
      currentvalue = Puppet::Util::Execution.execute(
        "cd /; git config --#{scope} --get #{key}",
        uid: user,
        failonfail: false,
        custom_environment: { 'HOME' => home },
      ).strip
      next if currentvalue.empty?

      ret.push(
        ensure: 'present',
        key: key,
        user: user,
        scope: scope,
        value: currentvalue,
      )
    end
    ret
  end

  def create(_context, name, should)
    home = Etc.getpwnam(name[:user])[:dir]

    Puppet::Util::Execution.execute(
      "cd / ; git config --#{name[:scope]} #{name[:key]} #{should[:value].shellescape}",
      uid: name[:user],
      failonfail: true,
      combine: true,
      custom_environment: { 'HOME' => home },
    )
  end

  def update(context, name, should)
    create(context, name, should)
  end

  def delete(_context, name)
    home = Etc.getpwnam(name[:user])[:dir]
    Puppet::Util::Execution.execute(
      "cd / ; git config --unset --#{name[:scope]} #{name[:key]}",
      uid: name[:user],
      failonfail: true,
      combine: true,
      custom_environment: { 'HOME' => home },
    )
  end
end
