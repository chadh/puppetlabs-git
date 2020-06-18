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
  features: [
    'simple_get_filter',
  ],
  attributes: {
    ensure: {
      type: 'Enum[present, absent]',
      desc: 'whether config is present or absent',
      default: 'present',
    },
    key: {
      type: 'String',
      desc: 'the key for which to set a value',
      behavior: :namevar,
    },
    user: {
      type: 'Optional[String]',
      desc: 'The user for which the config will be set.',
      behavior: :namevar,
      default: 'root',
    },
    scope: {
      type: 'Optional[Enum[global, system]]',
      desc: 'The scope of the configuration.',
      behavior: :namevar,
      default: 'global',
    },
    value: {
      type: 'Variant[String,Integer,Boolean]',
      desc: 'The config value.  Example "Mike Color" or "john.doe@example.com"',
    },
  },
)
