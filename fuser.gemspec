lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fuser/version'

Gem::Specification.new do |spec|
  spec.name          = 'fuser'
  spec.version       = Fuser::VERSION
  spec.authors       = ['DeeMak13']
  spec.email         = ['deemakk13@gmail.com']

  spec.summary       = "Firebase Authentication and User Management"
  spec.description   = "Ruby wrapper for Firebase's native and third-party authentication."
  spec.homepage      = 'https://github.com/DeeMak13/fuser'
  spec.license       = 'MIT'

  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'httparty', '~> 0.16.2'
  spec.add_runtime_dependency 'i18n', '~> 1.1', '>= 1.1.0'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'webmock', '~> 3.4', '>= 3.4.2'
  spec.add_development_dependency 'dotenv'
end
