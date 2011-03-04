# encoding: utf-8

module Shkuph::Marshal # :nodoc:
end

class Shkuph::Marshal::Hash
  def initialize(klass = Hash)
    @klass = klass
  end

  def dump(value)
    case value
      when Hash then value
      when nil then {}
    else
      value.to_hash
    end
  end

  def load(dump)
    return nil unless dump
    return dump if @klass.is_a? Hash
    @klass.from_hash(dump)
  end
end
