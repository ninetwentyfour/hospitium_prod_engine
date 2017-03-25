module HospitiumProdEngine
  class Engine < ::Rails::Engine
    isolate_namespace HospitiumProdEngine

    config.to_prepare do

    end
    
    initializer "hospitium_prod_engine", after: :load_config_initializers do |app|
      HospitiumProdEngine.load_files.each { |file|
        require_relative File.join("../..", file)
      }
    end
  end
end
