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

  # Calling unscoped is blocked to prevent data leakage. You can define
  # exceptions here.
  # 
  # default: config.allowed_unscoped_callers = ['_create_record', 'scope', 'update_positions', 'validate_each', 'eval_scope', '_update_record']
  #
  config.allowed_unscoped_callers = ['_create_record', 'scope', 'update_positions', 'validate_each', 'eval_scope', '_update_record']

  # Calling unscoped is blocked to prevent data leakage. You can override the behaviour of unscoped
  # here. If the caller is in this list, it wont get the unscoped scope, but a client scoped relation.
  # 
  # default: config.force_client_scope_for_unscoped_callers = ['aggregate_column']
  #
  config.force_client_scope_for_unscoped_callers = ['aggregate_column']

end
