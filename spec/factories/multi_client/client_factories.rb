FactoryGirl.define do
  factory :multi_client_client, class: MultiClient::Client do
    sequence(:identifier) { |i| "client.identifier.#{i}"}
    sequence(:subdomain)  { |i| "client#{i}"}
    enabled true

    trait(:master) do
      identifier MultiClient::Configuration.master_client_identifier
      subdomain 'master'
    end
  end
end
