module MultiClient
  module ModelWithClient
    extend ActiveSupport::Concern

    included do
      belongs_to :client, class_name: 'MultiClient::Client'

      scope :for_current_client, lambda { where(client_id: Client.current_id) }
      default_scope lambda { for_current_client }

      validates :client_id, presence: true
    end

    class_methods do
      # def unscoped
      #   raise UnscopedForbiddenError # 'Unscoped is not allowed to prevent client data leakage'
      # end
    end
  end
end