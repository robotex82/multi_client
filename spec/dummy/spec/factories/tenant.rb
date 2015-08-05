FactoryGirl.define do
  factory :tenant do
    sequence :subdomain
    sequence :identifier
  end
end
