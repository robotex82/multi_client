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
        return where(MultiClient::Configuration.foreign_key.to_sym => MultiClient::Configuration.model_name.constantize.current_id) if caller_locations(1,1)[0].label == 'aggregate_column'

        # Experimental
        # return where(MultiClient::Configuration.foreign_key.to_sym => MultiClient::Configuration.model_name.constantize.current_id) if  ['aggregate_column', 'bottom_item', 'scope_for_slug_generator'].include?(caller_locations(1,1)[0].label)

        if ['_create_record', 'scope', 'validate_each', 'eval_scope', '_update_record', 'aggregate_column', 'bottom_item', 'scope_for_slug_generator'].include?(caller_locations(1,1)[0].label)
          super
        else
          raise UnscopedForbiddenError, "Calling unscoped from #{caller_locations(1,1)[0].label} is not allowed to prevent client data leakage" 
        end
      end
    end
  end
end