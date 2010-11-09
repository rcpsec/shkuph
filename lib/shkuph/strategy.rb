# encoding: utf-8

class Shkuph::Strategy
  def dump(value)
    raise NotImplementedError
  end

  def load(dump)
    raise NotImplementedError
  end
end
