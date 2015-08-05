module MultiClient
  module ModelWithClient
    extend ActiveSupport::Concern

    included do
      belongs_to MultiClient::Configuration.method_name.to_sym, class_name: MultiClient::Configuration.model_name

      scope "for_current_#{MultiClient::Configuration.method_name}".to_sym, lambda { where(MultiClient::Configuration.foreign_key.to_sym => MultiClient::Configuration.model_name.constantize.current_id) }
      default_scope lambda { send("for_current_#{MultiClient::Configuration.method_name}".to_sym) }

      validates MultiClient::Configuration.foreign_key.to_sym, presence: true
    end

    class_methods do
      # def unscoped
      #   raise UnscopedForbiddenError # 'Unscoped is not allowed to prevent client data leakage'
      # end
    end
  end
end