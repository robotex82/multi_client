module MultiClient
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc 'Generates the initializer'

      source_root File.expand_path('../templates', __FILE__)

      def generate_intializer
        copy_file 'initializer.rb', 'config/initializers/multi_client.rb'
      end

      def generate_client_model
        copy_file 'client.rb', 'app/models/client.rb'
      end
    end
  end
end
