require_relative 'lib/off_the_grid/version'

Gem::Specification.new do |s|
  s.description = 'The Ruby library for interacting with Son of Grid Engine'
  s.name        = 'off_the_grid'
  s.version     = OffTheGrid.version.to_s
  s.date        = Time.now.strftime('%Y-%m-%d')
  s.summary     = 'Off The Grid can perform basic management tasks for SGE.'
  s.authors     = ['Jonathan Gnagy', 'Daniel Schaaff']
  s.email       = 'jgnagy@knuedge.com'
  s.files       = [
    'lib/off_the_grid.rb',
    'lib/off_the_grid/access_list.rb',
    'lib/off_the_grid/admin_host.rb',
    'lib/off_the_grid/erb_helpers.rb',
    'lib/off_the_grid/execute_host.rb',
    'lib/off_the_grid/grid_resource.rb',
    'lib/off_the_grid/host_group.rb',
    'lib/off_the_grid/host.rb',
    'lib/off_the_grid/named_resource.rb',
    'lib/off_the_grid/project.rb',
    'lib/off_the_grid/submit_host.rb',
    'lib/off_the_grid/templates/execute_host.rb',
    'lib/off_the_grid/templates/project.rb',
    'lib/off_the_grid/templates/user.rb',
    'lib/off_the_grid/user.rb',
    'lib/off_the_grid/version.rb',
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
