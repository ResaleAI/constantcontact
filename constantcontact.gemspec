# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.name = 'constantcontact'
  s.version = '2.2.1'
  s.platform = Gem::Platform::RUBY
  s.authors = ['ConstantContact']
  s.homepage = 'http://www.constantcontact.com'
  s.summary = 'Constant Contact SDK for Ruby'
  s.email = 'webservices@constantcontact.com'
  s.description = 'Ruby library for interactions with Constant Contact v2 API'
  s.license = 'MIT'

  s.files = [
    '.rspec',
    'constantcontact.gemspec',
    'README.md'
  ]
  s.files += Dir['lib/**/*.rb']
  s.executables = []
  s.require_paths = ['lib']
  s.test_files = Dir['spec/**/*_spec.rb']

  s.add_runtime_dependency('rest-client', '~> 2.0', '>= 2.0.0')
  s.add_runtime_dependency('json', '~> 2.3.1', '>= 2.3')
  s.add_runtime_dependency('mime-types', '~> 2.4', '>= 2.4.1')
  s.add_development_dependency('rspec', '~> 2.14')
end
