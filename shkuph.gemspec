# encoding: utf-8

$:.unshift File.expand_path('../lib', __FILE__)

require 'shkuph/version'

Gem::Specification.new do |s|
  s.name         = 'shkuph'
  s.version      = Shkuph::Version.to_s
  s.authors      = [ 'Dmitry A. Ustalov', 'Yehuda Katz' ]
  s.email        = 'dmitry@eveel.ru'
  s.homepage     = 'http://github.com/eveel/shkuph'
  s.summary      = 'Shkuph: A Comfortable and Unified KVS Interface.'
  s.description  = s.summary

  s.files        = Dir.glob('lib/**/**')
  s.platform     = Gem::Platform::RUBY
  s.require_path = 'lib'
  s.rubyforge_project = '[none]'

  s.add_development_dependency 'ruby-debug19'
  s.add_development_dependency 'bluecloth'
  s.add_development_dependency 'yard'
  s.add_development_dependency 'shoulda'
  s.add_development_dependency 'mg'
  s.add_development_dependency 'rcov'

  s.required_rubygems_version = '>= 1.3.7'
end
