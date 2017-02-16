module MultiClient
  module SpecHelpers
    module Feature
      def use_client(client)
        MultiClient::Client.current_id = client.id
        Capybara.current_session.driver.reset!
        Capybara.default_host = Capybara.default_host.sub(/(.*?\/\/)(.*?)(\..*)/, "\\1#{client.subdomain}\\3")      
      end

      def with_client(client, &block)
        MultiClient::Client.with_client(client) { block.call }
      end

      def use_subdomain(subdomain)
        Capybara.current_session.driver.reset!
        Capybara.default_host = Capybara.default_host.sub(/(.*?\/\/)(.*?)(\..*)/, "\\1#{subdomain}\\3")      
      end

      def with_subdomain(subdomain, &block)
        original_host = Capybara.default_host
        use_subdomain(subdomain)
        yield
        Capybara.default_host = original_host
      end
    end
  end
end