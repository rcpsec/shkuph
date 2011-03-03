# encoding: utf-8

require 'helper'

require 'shkuph/marshal/string'

class Shkuph::Marshal::StringTest < MiniTest::Unit::TestCase
  context 'Shkuph String Marshal' do
    subject { Shkuph::Marshal::String }

    should 'dump only String values' do
      value = 'value'
      assert_equal value, subject.dump(value)
    end

    should 'load only String values' do
      value = 'value'
      assert_equal value, subject.load(value)
    end

    should 'dump nil values as empty String' do
      assert_equal '', subject.dump(nil)
    end

    should 'load nil values as nils' do
      assert_nil subject.load(nil)
    end

    should 'dump Integers as Strings' do
      assert_equal '3', subject.dump(3)
    end

    should 'refuse to dump non-String values' do
      assert_raises TypeError do
        subject.dump(Object.new)
      end
    end

    should 'refuse to load non-String dump' do
      assert_raises TypeError do
        subject.load(Object.new)
      end
    end
  end
end
