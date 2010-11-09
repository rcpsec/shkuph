# encoding: utf-8

begin
  require 'gdbm'
rescue LoadError
  raise UnsatisfiedDependency,
    "can not require the 'gdbm' library or gem, " \
    "please check it out and try again later"
end

require 'forwardable'

class Shkuph::Adapters::GDBM  
  include Shkuph::Storage
  include Enumerable
  extend Forwardable

  attr_accessor :keystrat, :valstrat

  def initialize(filename, mode, key_strategy, value_strategy)
    @keystrat, @valstrat = key_strategy, value_strategy

    gdbm_mode = if :manage == mode
      ::GDBM::WRCREAT
    else
      ::GDBM::READER | ::GDBM::NOLOCK
    end

    @shkuph = ::GDBM.new(filename, 0666, gdbm_mode)
  end

  def get(key)
    valstrat.load(@shkuph[keystrat.dump(key)])
  end

  def set(key, value)
    @shkuph[keystrat.dump(key)] = valstrat.dump(value)
  end

  def each(&block)
    # it is pretty slow, but so fucking useful
    @shkuph.each_pair do |key, value|
      block.call(keystrat.load(key), valstrat.load(value))
    end
  end

  def key?(key)
    @shkuph.has_key? keystrat.dump(key)
  end

  def delete(key)
    if value = self[key]
      @shkuph.delete keystrat.dump(key)
      value
    end
  end

  def_delegators :@shkuph, :clear
  def_delegators :@shkuph, :close
end
