# encoding: utf-8

require 'minitest/unit'
require 'shoulda'

class MiniTest::Unit::TestCase
  include Shoulda::InstanceMethods
  extend Shoulda::ClassMethods
  include Shoulda::Assertions
  extend Shoulda::Macros
  include Shoulda::Helpers
end

module MiniTest::Assertions
  def assert_not_same exp, act, msg = nil
    msg = message(msg) {
      data = [mu_pp(act), act.object_id, mu_pp(exp), exp.object_id]
        "Expected %s (oid=%d) to be the same as %s (oid=%d)" % data
    }
    assert !exp.equal?(act), msg
  end
end

require File.expand_path('../../lib/shkuph.rb', __FILE__)
$:.unshift File.expand_path('../../lib', __FILE__)
require 'shoulda_macros/behave_as_key_value_store'
