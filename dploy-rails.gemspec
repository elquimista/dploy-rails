# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "dploy/rails/version"

Gem::Specification.new do |spec|
  spec.name          = "dploy-rails"
  spec.version       = Dploy::Rails::VERSION
  spec.authors       = ["artificis"]
  spec.email         = ["artificis@protonmail.ch"]

  spec.summary       = %q{Simple Rails deployer for VPS and Nginx}
  spec.description   = %q{Simple Rails deployer for VPS and Nginx (or similar reverse proxy server).}
  spec.homepage      = "https://github.com/knocknock-team/dploy-rails"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"

  spec.add_runtime_dependency "net-ssh", "~> 4.1.0"
  spec.add_runtime_dependency "colored", "~> 1.2"

  spec.add_dependency "railties", ">= 4.2.0"
end
