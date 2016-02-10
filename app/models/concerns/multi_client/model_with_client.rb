module MultiClient
  module ModelWithClient
    extend ActiveSupport::Concern

    included do
      klass = Class.new(self) do
        default_scope { unscoped }
        
        def unscoped
          super
        end
      end
      self.const_set 'Unscoped', klass

      belongs_to MultiClient::Configuration.method_name.to_sym, class_name: MultiClient::Configuration.model_name

      scope "for_current_#{MultiClient::Configuration.method_name}".to_sym, lambda { where(MultiClient::Configuration.foreign_key.to_sym => MultiClient::Configuration.model_name.constantize.current_id) }
      default_scope { send("for_current_#{MultiClient::Configuration.method_name}".to_sym) }

      validates MultiClient::Configuration.foreign_key.to_sym, presence: true

      ::MultiClient::Client.has_many self.name.demodulize.underscore.pluralize.to_sym, class_name: "::#{self.name}", foreign_key: MultiClient::Configuration.foreign_key.to_sym

    end

    class_methods do
      def unscoped
        return super if self.name.demodulize == 'Unscoped'
        caller = caller_locations(1,1)[0].label
        return where(MultiClient::Configuration.foreign_key.to_sym => MultiClient::Configuration.model_name.constantize.current_id) if MultiClient::Configuration.force_client_scope_for_unscoped_callers.include?(caller)
        return super if MultiClient::Configuration.allowed_unscoped_callers.include?(caller)
        raise UnscopedForbiddenError, "Calling unscoped from #{caller} is not allowed to prevent client data leakage" 
      end
    end
  end
end