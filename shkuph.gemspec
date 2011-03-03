# encoding: utf-8

require File.expand_path('../lib/shkuph.rb', __FILE__)

Gem::Specification.new do |s|
  s.name         = 'shkuph'
  s.version      = Shkuph.version
  s.authors      = [ 'Dmitry A. Ustalov', 'Yehuda Katz' ]
  s.email        = 'dmitry@eveel.ru'
  s.homepage     = 'https://github.com/eveel/shkuph'
  s.summary      = 'Shkuph: Key-Value Storage Interface.'
  s.description  = 'Shkuph: A Comfortable and Unified ' \
                   'Key-Value Storage Interface.'

  s.files        = Dir.glob('lib/**/**')
  s.platform     = Gem::Platform::RUBY
  s.require_path = 'lib'
  s.rubyforge_project = '[none]'

  s.add_development_dependency 'shoulda'

  s.required_rubygems_version = '>= 1.3.6'
end
