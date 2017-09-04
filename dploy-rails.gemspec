# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "dploy/rails/version"

Gem::Specification.new do |spec|
  spec.name          = "dploy-rails"
  spec.version       = Dploy::Rails::VERSION
  spec.authors       = ["dark.turtle"]
  spec.email         = ["dark.turtle@protonmail.com"]

  spec.summary       = %q{Simple Rails deployer for VPS and Nginx}
  spec.description   = %q{Simple Rails deployer for VPS and Nginx (or similar reverse proxy server).}
  spec.homepage      = "https://github.com/knocknock-team/dploy-rails"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

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
end
