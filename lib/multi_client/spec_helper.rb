module MultiClient
  module SpecHelper
    def use_tenant(tenant)
      Tenant.current_id = tenant.id
      Capybara.current_session.driver.reset!
      Capybara.default_host = Capybara.default_host.sub(/(.*?\/\/)(.*?)(\..*)/, "\\1#{tenant.subdomain}\\3")      
    end
  end
end