# encoding: utf-8

require 'minitest/unit'

$:.unshift File.expand_path('../../lib', __FILE__)
$:.unshift File.dirname(__FILE__)

require 'shkuph'

Bundler.require(:default, :development)

class MiniTest::Unit::TestCase
  include Shoulda::InstanceMethods
  extend Shoulda::ClassMethods
  include Shoulda::Assertions
  extend Shoulda::Macros
  include Shoulda::Helpers
end

require 'minitest_additional_assertions'
require 'shoulda_macros/behave_as_key_value_store'
