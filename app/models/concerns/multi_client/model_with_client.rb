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
      
      namespace = self.name.deconstantize
      namespace = '::Object' if namespace.empty?
      klass_name = "#{self.name.demodulize}Unscoped"
      Rails.logger.info "Defining #{klass_name} on #{namespace}"
      namespace.constantize.const_set klass_name, klass

      belongs_to MultiClient::Configuration.method_name.to_sym, class_name: MultiClient::Configuration.model_name

      scope "for_current_#{MultiClient::Configuration.method_name}".to_sym, -> { where(MultiClient::Configuration.foreign_key.to_sym => MultiClient::Configuration.model_name.constantize.current_id) }
      default_scope { send("for_current_#{MultiClient::Configuration.method_name}".to_sym) }

      validates MultiClient::Configuration.foreign_key.to_sym, presence: true

      ::MultiClient::Client.has_many name.demodulize.underscore.pluralize.to_sym, class_name: "::#{name}", foreign_key: MultiClient::Configuration.foreign_key.to_sym
    end

    class_methods do
      def unscoped
        return super if name =~ /.*Unscoped/
        caller = caller_locations(1, 1)[0].label
        return where(MultiClient::Configuration.foreign_key.to_sym => MultiClient::Configuration.model_name.constantize.current_id) if MultiClient::Configuration.force_client_scope_for_unscoped_callers.include?(caller)
        return super if MultiClient::Configuration.allowed_unscoped_callers.include?(caller)
        raise UnscopedForbiddenError, "Calling unscoped from #{caller} is not allowed to prevent client data leakage"
      end
    end
  end
end
