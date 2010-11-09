# encoding: utf-8

require 'helper'

require 'shkuph/strategies/marshal_strategy'

class Shkuph::TestMarshalStrategy < MiniTest::Unit::TestCase
  context 'Shkuph Strategies: Marshal' do
    subject { @strategy ||= Shkuph::MarshalStrategy.new }

    should 'be successor of Shkuph::Strategy' do
      subject.is_a? ::Shkuph::Strategy
    end

    types = {
      'String' => [ 'key', 'key2' ],
      'Object' => [ { :foo => :bar }, { :bar => :baz } ]
    }

    types.each do |type, (key, key2)|
      should "dump #{type} values" do
        assert_equal Marshal.dump(key), subject.dump(key)
      end

      should "load #{type} values" do
        dump = subject.dump(key)
        assert_equal key, subject.load(dump)
      end
    end

    should 'load nil values as nils' do
      assert_nil subject.load(nil)
    end
  end
end
