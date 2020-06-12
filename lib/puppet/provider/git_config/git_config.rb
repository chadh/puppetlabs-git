require 'puppet/resource_api/simple_provider'
require 'etc'
require 'shellwords'

class Puppet::Provider::GitConfig::GitConfig
  def get(context)
    []
  end

  def set(context, changes)
    changes.each do | name, change |
      should = change[:should]
      value = should[:value]
      user = should[:user]
      key = should[:key]
      scope = should[:scope]
      home = Etc.getpwnma(user)[:dir]

      current = Puppet::Util::Execution.execute(
        "cd /; git config --#{scope} --get #{name}",
        :uid => user,
        :failonfail => false,
        :custom_environment => { 'HOME' => home }
      ).strip

      if current != value
        Puppet::Util::Execution.execute(
          "cd / ; git config --#{scope} #{name} #{value.shellescape}",
          :uid => user,
          :failonfail => true,
          :combine => true,
          :custom_environment => { 'HOME' => home }
        )
      end
    end
  end
end
