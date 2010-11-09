# encoding: utf-8

class Shkuph::MarshalStrategy < Shkuph::Strategy
  def dump(value)
    Marshal.dump(value)
  end

  def load(dump)
    dump && Marshal.load(dump)
  end
end
