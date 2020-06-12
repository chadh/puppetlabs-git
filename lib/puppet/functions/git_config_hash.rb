#
# config_hash.rb
#

Puppet::Functions.create_function(:git_config_hash) do
  # @param config possibly non-canonical configuration hash
  # @return [String] canonicalized configuration hash
  # @example Calling the function
  #
  #  git_config_hash({"foo" => 1, "bar" => {"value" => 2}}) 
  #
  #  returns {"foo" => {"value" => 1}, "bar" => {"value" => 2}}
  #
  dispatch :git_config_hash do
    param 'Hash', :configs
    return_type 'Hash'
  end

  def git_config_hash(configs)
    return Hash[configs.map {|k, v| [k, v.is_a?(Hash) ? v : {"value" => v}] }]
  end
end
