FactoryGirl.define do
  factory :multi_client_client, class: MultiClient::Client do
    sequence(:identifier)
    sequence(:subdomain)
    enabled true
  end
end
