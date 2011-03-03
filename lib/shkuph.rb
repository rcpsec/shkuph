# encoding: utf-8

# Shkuph: A Comfortable and Unified
# Key-Value Storage Interface.
module Shkuph
  class << self
    # Shkuph Semantic Version
    # (http://semver.org/) specification.
    #
    # ==== Returns
    # String:: Shkuph semantic version.
    #
    def version
      '0.1.1'
    end
  end

  class Base
    include Enumerable

    attr_reader :filename, :options
    attr_reader :key_marshal, :value_marshal

    # Initialize the Shkuph Key-Value Storage Interface.
    #
    # ==== Paremeters
    # filename<String>:: Database filename.
    # configuration<Hash>:: Options to describe Shkuph behaviour.
    #
    def initialize(filename, configuration = {})
      @filename = filename
      @options = configuration.delete(:options) || {}

      key_marshal = configuration.delete(:key_marshal)
      if !key_marshal.respond_to?(:dump) ||
         !key_marshal.respond_to?(:load)
        raise ArgumentError,
          'Key Marshal do not respond to #dump and #load'
      end
      @key_marshal = key_marshal

      value_marshal = configuration.delete(:value_marshal)
      if !value_marshal.respond_to?(:dump) ||
         !value_marshal.respond_to?(:load)
        raise ArgumentError,
          'Value Marshal do not respond to #dump and #load'
      end
      @value_marshal = value_marshal

      unless configuration.empty?
        raise ArgumentError, configuration.inspect
      end
    end

    def inspect
      "\#<#{self.class.name} filename='#{filename}'>"
    end
    alias :to_s :inspect

    # Try to get(key) and put some default value
    # when it is absent.
    #
    # ==== Parameters
    # key<Object>:: Key.
    # value<Object>:: Default value.
    #
    # ==== Returns
    # Object:: Obtained value.
    #
    def fetch(key, value = nil)
      self[key] || begin
        block_given? ? yield(key) : value
      end
    end

    # Just get it.
    #
    # ==== Parameters
    # key<Object>:: Key.
    #
    # ==== Returns
    # Object:: Obtained value.
    #
    def get(key)
      raise NotImplementedError
    end

    def [] key # :nodoc:
      get(key)
    end

    # Just set it.
    #
    # ==== Parameters
    # key<Object>:: Key.
    # value<Object>:: Value.
    #
    # ==== Returns
    # Object:: Set value.
    #
    def set(key, value)
      raise NotImplementedError
    end

    def []= key, value # :nodoc:
      set(key, value)
    end

    # Perform each-loop.
    #
    # ==== Returns
    # Shkuph:: self.
    #
    def each(&block)
      raise NotImplementedError
    end

    # Check key exitance in the storage.
    #
    # ==== Parameters
    # key<Object>:: Key.
    #
    # ==== Returns
    # True or False.
    #
    def key?(key)
      raise NotImplementedError
    end

    # Remove record named key.
    #
    # ==== Parameters
    # key<Object>:: Key.
    #
    # ==== Returns
    # Object:: Value.
    def delete(key)
      raise NotImplementedError
    end

    # Clear storage.
    #
    # ==== Returns
    # Nothing.
    #
    def clear
      raise NotImplementedError
    end

    # Close storage.
    #
    # ==== Returns
    # Nothing.
    #
    def close
      raise NotImplementedError
    end

    protected
      def key_load(dump)
        dump && key_marshal.load(dump)
      end

      def key_dump(key)
        key_marshal.dump(key)
      end

      def value_load(dump)
        dump && value_marshal.load(dump)
      end

      def value_dump(value)
        value_marshal.dump(value)
      end
  end
end
