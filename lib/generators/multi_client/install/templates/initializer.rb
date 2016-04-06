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
  # default: config.allowed_unscoped_callers = %w(
  #   _create_record 
  #   _update_record 
  #   aggregate_column 
  #   bottom_item 
  #   eval_scope
  #   relation_for_destroy 
  #   reload 
  #   scope
  #   scope_for_slug_generator 
  #   update_counters
  #   update_positions 
  #   validate_each
  # )
  #
  config.allowed_unscoped_callers = %w(
    _create_record 
    _update_record 
    aggregate_column 
    bottom_item 
    eval_scope
    relation_for_destroy 
    reload 
    scope
    scope_for_slug_generator 
    update_counters
    update_positions 
    validate_each
  )

  # Calling unscoped is blocked to prevent data leakage. You can override the behaviour of unscoped
  # here. If the caller is in this list, it wont get the unscoped scope, but a client scoped relation.
  #
  # default: config.force_client_scope_for_unscoped_callers = ['aggregate_column']
  #
  config.force_client_scope_for_unscoped_callers = ['aggregate_column']

  # Proc, that will be called to check, if a client specific domain was given.
  # It takes one param, the current request. This should return an array.
  # 
  # Default: config.no_subdomain_prefixes = ->(request) { ['www', '', nil] }
  # 
  config.no_subdomain_prefixes = ->(request) { ['www', '', nil] }

  # The master tenant is a special tenant. You can ask Tenant.master? to
  # check, if the actual tenant is the master tenant.
  # 
  # Default: config.master_tenant_identifier = '000'
  # 
  config.master_tenant_identifier = '000'
end
