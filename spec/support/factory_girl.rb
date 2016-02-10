require 'factory_girl_rails'

FactoryGirl.definition_file_paths << Rails.root.join(File.join('spec', 'factories'))
FactoryGirl.reload

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end
