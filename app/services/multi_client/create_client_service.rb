module MultiClient
  class CreateClientService < Itsf::Services::V2::Service::Base
    class Response < Itsf::Services::V2::Response::Base
      # attr_accessor :client, :client_setting, :users, :licensed_products, :roles, :permissions
      attr_accessor :client, :users, :roles, :permissions
    end

    # attr_accessor :subdomain, :identifier, :enabled, :brand_primary_color, :logo, :user_emails, :product_ids, :create_roles_and_permissions, :request_host
    attr_accessor :subdomain, :identifier, :enabled, :user_emails, :create_roles_and_permissions, :request_host

    # validates :subdomain, :identifier, :enabled, :brand_primary_color, :logo, :user_emails, :create_roles_and_permissions, :request_host, presence: true
    validates :subdomain, :identifier, :enabled, :user_emails, :create_roles_and_permissions, :request_host, presence: true
  
    def do_work
      say "Running on environment #{Rails.env}"
      say "Validating input"
      return response unless valid?
      say "Input is valid"
      ActiveRecord::Base.transaction do
        response.client = create_client
        return response unless response.client.persisted?
        Client.with_client(response.client) do
          # response.client_setting = create_client_setting
          response.roles, response.permissions = create_default_roles_and_permissions if create_roles_and_permissions == true
          response.users = create_users
          # response.licensed_products = create_licensed_products
          raise ActiveRecord::Rollback if errors.any?
          request_user_password_resets(response.users.map(&:email))
        end
      end
      say "Done"
      respond
    end

    private

    def create_client
      say "Creating client", indent: 1
      client = Client.new(client_attributes)
      if client.save
        say "Created #{client.class} #{client}", indent: 2
      else
        add_error_and_say :client, "Error creating #{client.class} #{client}. Errors: #{client.errors.full_messages.to_sentence}", indent: 2
      end
      say "Done", indent: 1
      return client
    end

    # def create_client_setting
    #   say "Creating client setting", indent: 1
    #   client_setting = ClientSetting.new(client_setting_attributes)
    #   if client_setting.save
    #     say "Created #{client_setting.class} #{client_setting}", indent: 2
    #   else
    #     add_error_and_say :client_setting, "Error creating #{client_setting.class} #{client_setting}. Errors: #{client_setting.errors.full_messages.to_sentence}", indent: 2
    #   end
    #   say "Done", indent: 1
    #   return client_setting
    # end

    def create_default_roles_and_permissions
      say "Creating roles", indent: 1
      result = Ecm::Rbac::ImportDefaultPermissionsService.call
      if result.success?
        say "Created roles", indent: 2
      else
        add_error_and_say :create_roles_and_permissions, "Error creating roles. Errors: #{result.errors.full_messages.to_sentence}", indent: 2
      end
      say "Done", indent: 1
      return result.roles, result.permissions
    end

    def create_users
      say "Creating #{splitted_user_emails.size} users", indent: 1
      users = splitted_user_emails.collect do |user_email|
        create_user(user_email)
      end
      say "Done", indent: 1
      return users
    end

    def create_user(email)
      say "Creating user", indent: 1
      random_password = SecureRandom.hex
      user = Ecm::UserArea::User.new(email: email, password: random_password, password_confirmation: random_password, active: true, confirmed: true, approved: true, roles: user_roles)
      if user.save
        say "Created #{user.class} #{user}", indent: 2
      else
        add_error_and_say :user_emails, "Error creating #{user.class} #{user}. Errors: #{user.errors.full_messages.to_sentence}", indent: 2
      end
      say "Done", indent: 1
      return user
    end

    # def create_licensed_products
    #   say "Creating #{product_ids.size} licensed products", indent: 1
    #   licensed_products = product_ids.collect do |product_id|
    #     create_licensed_product(product_id)
    #   end
    #   say "Done", indent: 1
    #   return licensed_products
    # end

    # def create_licensed_product(product_id)
    #   say "Creating licensed product", indent: 1
    #   licensed_product = Chi::Licensing::LicensedProduct.new(licensee: response.client)
    #   licensed_product.product = load_product(product_id)
    #   if licensed_product.save
    #     say "Created #{licensed_product.class} #{licensed_product}", indent: 2
    #   else
    #     add_error_and_say :product_ids, "Error creating #{licensed_product.class} #{licensed_product}. Errors: #{licensed_product.errors.full_messages.to_sentence}", indent: 2
    #   end
    #   say "Done", indent: 1
    #   return licensed_product
    # end

    def client_attributes
      { subdomain: subdomain, identifier: identifier, enabled: enabled }
    end

    def client_setting_attributes
      { brand_primary_color: brand_primary_color, logo: logo }
    end

    def splitted_user_emails
      user_emails.split(/[^\w+@\.\+\-\_]/).delete_if { |email| !email.try(:include?, '@') }
    end

    def request_user_password_resets(emails)
      host = request_host.gsub(Client.master.subdomain, subdomain)
      emails.map do |email|
        Ecm::UserArea::UserPasswordResetRequest.call(email: email, host: host)
      end
    end

    # def load_product(product_id)
    #   Chi::Licensing::Product.where(id: product_id).first
    # end

    def create_roles_and_permissions
      if Rails.version < '5'
        ActiveRecord::Type::Boolean.new.type_cast_from_user(@create_roles_and_permissions)
      else
        ActiveRecord::Type::Boolean.new.cast(@create_roles_and_permissions)
      end
    end

    def user_roles
      [
        Ecm::Rbac::Role.where(identifier: 'rt_imager/admin').first,
        Ecm::Rbac::Role.where(identifier: 'rt_imager/web').first,
      ].compact
    end

    # def product_ids
    #   @product_ids ||= []
    # end
  end
end
