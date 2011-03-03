begin
  require 'tokyocabinet'
rescue LoadError
  raise StandardError,
    "can't require 'tokyocabinet' library or gem, " \
    "please check it out and try again later"
end

require 'forwardable'

module Shkuph::TokyoCabinet # :nodoc:
end

class Shkuph::TokyoCabinet::Table < Shkuph::Base # :nodoc:
  include TokyoCabinet
  extend Forwardable

  def initialize(filename, configuration = {})
    super(filename,
      configuration.merge(:value_marshal => Marshal)
    )

    @shkuph = TDB::new

    table_mode = if :manage == options[:mode]
      TDB::OWRITER | TDB::OCREAT
    else
      TDB::OREADER | TDB::ONOLOCK
    end

    if !@shkuph.open(filename, table_mode)
      ecode = @shkuph.ecode
      raise @shkuph.errmsg(ecode)
    end
  end

  def get(key)
    @shkuph[key_dump(key)]
  end

  def set(key, value)
    @shkuph[key_dump(key)] = value
  end

  def each(&block)
    @shkuph.each_pair do |key, value|
      block.call(key_load(key), value)
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

  def clear
    @shkuph.vanish
  end

  def_delegators :@shkuph, :close
end