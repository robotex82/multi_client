namespace :multi_client do
  namespace :create do
    desc "Explaining what the task does"
    task master_tenant: :environment do
      if MultiClient::Client.exists?(subdomain: 'master')
        puts "Master tenant already exists"
        next
      end
      if MultiClient::Client.enabled.create!(subdomain: 'master', identifier: MultiClient::Configuration.master_tenant_identifier)
        puts "Created master tenant"
      end
      puts "Done"
    end
  end
end