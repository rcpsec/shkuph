# encoding: utf-8

require 'helper'

require 'shkuph/marshal/hash'

class Shkuph::Marshal::TestHash < MiniTest::Unit::TestCase
  context 'Shkuph Hash Marshal' do
    subject { Shkuph::Marshal::Hash.new }

    should 'dump Hash values' do
      value = { :foo => 'bar' }
      assert_equal value, subject.dump(value)
    end

    should 'load Hash values' do
      value = { :foo => 'bar' }
      assert_equal value, subject.load(value)
    end

    should 'dump nil values as empty Hash' do
      assert_equal Hash.new, subject.dump(nil)
    end
  end
end
