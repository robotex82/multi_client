require 'multi_client/engine'
require 'multi_client/configuration'

module MultiClient
  extend Configuration

  def self.table_name_prefix
    'multi_client_'
  end
end
