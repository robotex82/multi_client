module MultiClient
  module ControllerWithClient
    extend ActiveSupport::Concern

    included do
      around_action :set_current_client

      helper_method :current_client if respond_to?(:current_client)
    end

    private

    def client_class
      Configuration.model_name.constantize
    end

    def current_client
      @current_client ||= client_class.enabled.find(MultiClient::Client.current_id) if MultiClient::Client.current_id
    end

    def set_current_client
      redirect_to(root_url(subdomain: 'www')) && return unless current_client = client_class.enabled.find_by_subdomain(request.subdomains.first)
      client_class.current_id = current_client.id
      begin
        yield
      ensure
        @current_client = client_class.current_id = nil
      end
    end
  end
end
