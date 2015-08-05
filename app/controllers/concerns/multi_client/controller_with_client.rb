module MultiClient
  module ControllerWithClient
    extend ActiveSupport::Concern

    included do
      around_action :set_current_client

      helper_method :current_client
    end

    private

    def current_client
      @current_client ||= MultiClient::Client.find(MultiClient::Client.current_id)
    end

    def set_current_client
      redirect_to root_url(subdomain: 'www') and return unless current_client = MultiClient::Client.find_by_subdomain(request.subdomains.first)
      MultiClient::Client.current_id = current_client.id
      begin
        yield
      ensure
        @current_client = MultiClient::Client.current_id = nil
      end
    end
  end
end