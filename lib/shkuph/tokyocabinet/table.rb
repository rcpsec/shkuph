# encoding: utf-8

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
    super(filename, configuration)

    @shkuph = TDB.new

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
    value_load(
      @shkuph[key_dump(key)]
    )
  end

  def set(key, value)
    @shkuph[key_dump(key)] = value_dump(value)
  end

  def each(&block)
    return [] unless @shkuph.iterinit
    while (iterkey = @shkuph.iternext)
      key = key_load(iterkey)
      value = value_load(
        @shkuph[key]
      )
      block.call(key, value)
    end
  end

  # Performes a query to Table Database using
  # standard Tokyo Cabinet queries.
  #
  # ==== Parameters
  def query(query_proc, &block)
    TDBQRY.new(@shkuph).
      tap(&query_proc).
      search.each_with_index do |record, index|
        key = key_load(record)
        value = value_load(@shkuph[record])
        block.call([ key, value ], index)
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
