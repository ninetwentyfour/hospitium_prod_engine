module HospitiumProdEngine
  def self.load_files
    [
      "app/models/user"
    ]
  end
end

if defined?(::Rails)
  require 'hospitium_prod_engine/engine'
end
