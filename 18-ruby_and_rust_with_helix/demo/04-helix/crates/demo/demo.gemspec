Gem::Specification.new do |s|
  s.name = 'demo'
  s.version = '1.0.0'
  s.authors = ['Stanko Krtalic Rusendic <stanko.krtalic@gmail.com>']
  s.summary = "A Helix demo project"
  s.files = Dir['{lib/**/*,[A-Z]*}']

  s.platform = Gem::Platform::RUBY
  s.require_path = 'lib'

  s.add_dependency 'helix_runtime', '~> 0.7.2'
end
