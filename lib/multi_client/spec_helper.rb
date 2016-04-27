module MultiClient
  module SpecHelper
    def use_client(client)
      MultiClient::Client.current_id = client.id
      Capybara.current_session.driver.reset!
      Capybara.default_host = Capybara.default_host.sub(/(.*?\/\/)(.*?)(\..*)/, "\\1#{client.subdomain}\\3")      
    end
  end
end