module MultiClient
  module Configuration
    def configure
      yield self
    end

    mattr_accessor :model_name do
      'Client'
    end

    mattr_accessor :foreign_key do
      'client_id'
    end

    mattr_accessor :method_name do
      'client'
    end

    mattr_accessor(:allowed_unscoped_callers) {[]}

    mattr_accessor(:force_client_scope_for_unscoped_callers) {[]}

    def self.namespaced_model_name
      "MultiClient::#{model_name}"
    end
  end
end
