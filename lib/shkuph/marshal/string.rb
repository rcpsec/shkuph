# encoding: utf-8

module Shkuph::Marshal # :nodoc:
end

module Shkuph::Marshal::String
  class << self
    def dump(value)
      case value
        when String then value
        when Integer then value.to_s
        when nil then ''
      else
        raise TypeError
      end
    end

    def load(dump)
      case dump
        when String then dump
        when nil then ''
      else
        raise TypeError
      end
    end
  end
end
