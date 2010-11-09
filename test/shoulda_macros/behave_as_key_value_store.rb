# encoding: utf-8

class MiniTest::Unit::TestCase
  def self.should_behave_as_key_value_store
    types = {
      'String' => [ 'key', 'key2' ],
      'Object' => [ { :foo => :bar }, { :bar => :baz } ]
    }

    types.each do |type, (key, key2)|
      should "read from keys that are #{type}s like a Hash" do
        assert_nil subject[key]
      end

      should "write String values to keys that are #{type}s like a Hash" do
        subject[key] = 'value'
        assert 'value', subject[key]
      end

      should "guarantee that a different String value is retrieved from the #{type} key" do
        value = 'value'
        subject[key] = value
        assert_not_same value, subject[key]
      end

      should "write Object values to keys that are #{type}s like a Hash" do
        value = { :foo => :bar }
        subject[key] = value
        assert_equal value, subject[key]
      end

      should "guarantee that a different Object value is retrieved from the #{type} key" do
        value = { :foo => :bar }
        subject[key] = value
        assert_not_same value, subject[key]
      end

      should "return false from key? if a #{type} key is not available" do
        assert !subject.key?(key)
      end

      should "return true from key? if a #{type} key is available" do
        subject[key] = 'value'
        assert subject.key?(key)
      end

      should "remove and return an element with a #{type} key from the backing store via delete if it exists" do
        value = 'value'
        subject[key] = value
        assert_equal value, subject.delete(key)
        assert !subject.key?(key)
      end

      should "return nil from delete if an element for a #{type} key does not exist" do
        assert_nil subject.delete(key)
      end

      should "remove all #{type} keys from the store with clear" do
        subject[key] = 'value'
        subject[key2] = 'another value'
        subject.clear
        assert !subject.key?(key)
        assert !subject.key?(key2)
      end

      should "fetch a #{type} key with a default value with fetch, if the key is not available" do
        value = 'value'
        assert_equal value, subject.fetch(key, value)
      end

      should "fetch a #{type} key with a block with fetch, if the key is not available" do
        value = 'value'
        fetched = subject.fetch(key) do |key|
          value
        end
        assert_equal value, fetched
      end

      should "not run the block if the #{type} key is available" do
        subject[key] = 'value'
        unaltered = 'unaltered'
        subject.fetch(key) do |key|
          unaltered = 'altered'
        end
        assert_equal 'unaltered', unaltered
      end

      should "fetch a #{type} key with a default value with fetch, if the key is available" do
        value = 'stored value'
        subject[key] = value
        assert_equal value, subject.fetch(key, 'value')
      end

      should "store #{key} values with #set" do
        value = 'value'
        subject.set(key, value)
        assert_equal value, subject[key]
      end
    end

    should 'refuse to #[] from keys that cannot be marshalled' do
      assert_raises TypeError do
        subject[Struct.new(:foo).new(:bar)]
      end
    end

    should 'refuse to fetch from keys that cannot be marshalled' do
      assert_raises TypeError do
        subject.fetch(Struct.new(:foo).new(:bar), true)
      end
    end

    should 'refuse to #[]= to keys that cannot be marshalled' do
      assert_raises TypeError do
        subject[Struct.new(:foo).new(:bar)] = "value"
      end
    end

    should 'refuse to #set to keys that cannot be marshalled' do
      assert_raises TypeError do
        subject.set(Struct.new(:foo).new(:bar), 'value')
      end
    end

    should 'refuse to check for key? if the key cannot be marshalled' do
      assert_raises TypeError do
        subject.key? Struct.new(:foo).new(:bar)
      end
    end

    should 'refuse to delete a key if the key cannot be marshalled' do
      assert_raises TypeError do
        subject.delete Struct.new(:foo).new(:bar)
      end
    end

    should 'not be frozen' do
      assert !subject.frozen?
    end
  end
end
