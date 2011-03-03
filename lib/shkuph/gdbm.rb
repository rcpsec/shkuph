# encoding: utf-8

begin
  require 'gdbm'
rescue LoadError
  raise StandardError,
    "can't require 'gdbm' library or gem, " \
    "please check it out and try again later"
end

require 'forwardable'

class Shkuph::GDBM < Shkuph::Base
  extend Forwardable

  def initialize(filename, configuration = {})
    super(filename, configuration)

    gdbm_mode = if :manage == options[:mode]
      ::GDBM::WRCREAT
    else
      ::GDBM::READER | ::GDBM::NOLOCK
    end

    @shkuph = ::GDBM.new(filename, 0666, gdbm_mode)
  end

  def get(key)
    value_load(
      @shkuph[key_dump(key)]
    )
  end

  def set(key, value)
    @shkuph[key_dump(key)] = value_dump(value)
  end

  def each(&block)
    @shkuph.each_pair do |key, value|
      block.call(key_load(key), value_load(value))
    end
  end

  def key?(key)
    @shkuph.has_key? key_dump(key)
  end

  def delete(key)
    if value = self[key]
      @shkuph.delete key_dump(key)
      value
    end
  end

  def_delegators :@shkuph, :clear
  def_delegators :@shkuph, :close
end
