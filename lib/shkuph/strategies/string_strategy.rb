# encoding: utf-8

class Shkuph::StringStrategy < Shkuph::Strategy
  def dump(value)
    return '' unless value
    raise TypeError unless value.is_a? String
    value
  end

  def load(dump)
    return nil unless dump
    raise TypeError unless dump.is_a? String
    dump
  end
end