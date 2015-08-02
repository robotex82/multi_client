module MultiClient
  class Engine < ::Rails::Engine
    isolate_namespace MultiClient

    config.autoload_paths += Dir["#{config.root}/lib/**/"]
  end
end
