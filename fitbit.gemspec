# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'fitbit/version'

Gem::Specification.new do |spec|
  spec.name          = 'fitbit-api-client'
  spec.version       = Fitbit::VERSION
  spec.authors       = ['Kaoru Mori']
  spec.email         = ['kaoru.mori@gmail.com']

  spec.summary       = %q{Client for accessing Fitbit APIs.}
  spec.description   = %q{Client for accessing Fitbit APIs. This library supports OAuth 2.0.}
  spec.homepage      = 'https://github.com/kaorumori/fitbit-api-ruby-client'
  spec.license       = 'Apache-2.0'
  spec.required_ruby_version = '~> 2.1'

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'oauth2', '~> 1.0'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency "rspec", '~> 3'
end
