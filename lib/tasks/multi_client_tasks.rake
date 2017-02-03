namespace :multi_client do
  namespace :create do
    desc "Creates the master Tenant"
    task create_master: :environment do
      if MultiClient::Client.exists?(subdomain: 'master')
        puts "Master tenant already exists"
        next
      end
      if MultiClient::Client.enabled.create!(subdomain: 'master', identifier: MultiClient::Configuration.master_client_identifier)
        puts "Created master tenant (#{MultiClient::Configuration.master_client_identifier})"
      end
      puts "Done"
    end
  end
end