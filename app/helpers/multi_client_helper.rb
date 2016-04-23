module MultiClientHelper
  def render_client_navigation
    return unless MultiClient::Client.master?
    clients = MultiClient::Client.all
    render 'multi_client/client_navigation', clients: clients
  end
end
