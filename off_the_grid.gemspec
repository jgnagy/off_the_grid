# frozen_string_literal: true

require_relative 'lib/off_the_grid/version'

# rubocop:disable Metrics/BlockLength
Gem::Specification.new do |s|
  s.description = 'The Ruby library for interacting with Son of Grid Engine'
  s.name        = 'off_the_grid'
  s.version     = OffTheGrid.version.to_s
  s.date        = Time.now.strftime('%Y-%m-%d')
  s.summary     = 'Off The Grid can perform basic management tasks for SGE.'
  s.authors     = ['Jonathan Gnagy', 'Daniel Schaaff']
  s.email       = 'jgnagy@knuedge.com'
  s.files       = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  s.license     = 'MIT'
  s.platform    = Gem::Platform::RUBY

  s.required_ruby_version = '~> 2.3'
  s.post_install_message  = 'Thanks for installing Off The Grid!'
  s.homepage = 'https://github.com/knuedge/off_the_grid'

  s.bindir        = 'exe'
  s.executables   = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.require_paths = ['lib']

  s.metadata['yard.run'] = 'yri'

  # Dependencies

  s.add_development_dependency 'bundler', '~> 1.12'
  s.add_development_dependency 'rake', '~> 10.0'
  s.add_development_dependency 'rspec',   '~> 3.1'
  s.add_development_dependency 'rubocop', '~> 0.35'
  s.add_development_dependency 'yard',    '~> 0.8'
  s.add_development_dependency 'travis', '~> 1.8'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'coveralls'
  s.add_development_dependency 'byebug'
end
