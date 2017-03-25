$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "hospitium_prod_engine"
  s.version     = "0.0.1"
  s.authors     = ["Travis Berry"]
  s.summary     = "Things used in hospitium.co but not the open source app"

  s.files = Dir["{app,config,db,lib}/**/*"]

  s.add_dependency "rails", "~> 5.0.1"
  s.add_dependency "sendgrid-ruby"
end
