# encoding: utf-8

module Shkuph::Marshal
  module String
    class << self
      def dump(value)
        return '' unless value
        value = value.to_s if value.is_a? Integer
        raise TypeError unless value.is_a? String
        value
      end

      def load(dump)
        raise TypeError unless dump.is_a? String
        dump
      end
    end
  end
end
