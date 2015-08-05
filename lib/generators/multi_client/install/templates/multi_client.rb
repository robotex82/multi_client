MultiClient.configure do |config|
  # Client model name
  #
  # default: config.model_name = 'Client'
  config.model_name = 'Client'

  # Foreign key column
  #
  # default: config.foreign_key = 'client_id'
  config.foreign_key = 'client_id'

  # Method name pre/suffix
  #
  # default: config.method_name = 'client'
  config.method_name = 'client'
end
