require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'git_config',

  docs: <<-DOC,
  Used to configure git
  === Examples

   git_config { 'user.name':
     value => 'John Doe',
   }

   git_config { 'user.email':
     value => 'john.doe@example.com',
   }

   git_config { 'user.name':
     value   => 'Mike Color',
     user    => 'vagrant',
     require => Class['git'],
   }

   git_config { 'http.sslCAInfo':
     value   => $companyCAroot,
     user    => 'root',
     scope   => 'system',
     require => Company::Certificate['companyCAroot'],
   }
  DOC

  attributes: {
    ensure: {
      type: 'Enum[present, absent]',
      desc: 'whether config is present or absent',
      default: 'present',
    },
    name: {
      type: 'String',
      desc: 'The name of the config',
      behavior: :namevar,
    },
    value: {
      type: 'Variant[String,Integer,Boolean]',
      desc: 'The config value.  Example "Mike Color" or "john.doe@example.com"',
    },
    user: {
      type: 'Optional[String]',
      desc: 'The user for which the config will be set.',
      default: 'root',
    },
    key: {
      type: 'Optional[String]',
      desc: 'The configuration key.  Example "user.email"',
    },
    scope: {
      type: 'Optional[Enum[global, system]]',
      desc: 'The scope of the configuration.',
      default: 'global',
    },
  }
)
