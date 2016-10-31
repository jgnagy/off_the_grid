$LOAD_PATH.push File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'off_the_grid/version'

Gem::Specification.new do |s|
  s.description = 'The Ruby library for interacting with Son of Grid Engine'
  s.name        = 'off_the_grid'
  s.version     = OffTheGrid::VERSION.to_s
  s.date        = Time.now.strftime('%Y-%m-%d')
  s.summary     = 'Off The Grid can perform basic management tasks for SGE.'
  s.authors     = ['Jonathan Gnagy', 'Daniel Schaaff']
  s.email       = 'jgnagy@knuedge.com'
  s.files       = [
    'lib/off_the_record.rb',
    'lib/off_the_record/access_list.rb',
    'lib/off_the_record/admin_host.rb',
    'lib/off_the_record/erb_helpers.rb',
    'lib/off_the_record/execute_host.rb',
    'lib/off_the_record/grid_resource.rb',
    'lib/off_the_record/host_group.rb',
    'lib/off_the_record/host.rb',
    'lib/off_the_record/project.rb',
    'lib/off_the_record/submit_host.rb',
    'lib/off_the_record/templates/execute_host.rb',
    'lib/off_the_record/templates/project.rb',
    'lib/off_the_record/templates/user.rb',
    'lib/off_the_record/user.rb',
    'lib/off_the_record/version.rb',
    'LICENSE'
  ]

  s.license     = 'MIT'
  s.platform    = Gem::Platform::RUBY

  s.required_ruby_version = '~> 2.2'
  s.post_install_message  = 'Thanks for installing Off The Grid!'
  s.homepage = 'https://github.com/knuedge/off_the_grid'

  # Dependencies
  #s.add_runtime_dependency 'colorize',    '~> 0.7'

  s.add_development_dependency 'rspec',   '~> 3.1'
  s.add_development_dependency 'rubocop', '~> 0.35'
  s.add_development_dependency 'yard',    '~> 0.8'
end
