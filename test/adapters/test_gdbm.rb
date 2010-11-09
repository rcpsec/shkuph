# encoding: utf-8

require 'helper'

require 'shkuph/strategies/marshal_strategy'
require 'shkuph/adapters/gdbm'

class Shkuph::Adapters::TestGDBM < MiniTest::Unit::TestCase
  context 'Shkuph GDBM Adapter' do
    setup do
      key_strategy = value_strategy = Shkuph::MarshalStrategy.new
      @gdbm = Shkuph::Adapters::GDBM.new('test.gdbm', :manage,
        key_strategy, value_strategy)
    end

    teardown do
      @gdbm.close
      FileUtils.rm_f 'test.gdbm'
    end

    subject { @gdbm }

    if ENV['SHKUPH_TEST'].nil? || ENV['SHKUPH_TEST'] == 'gdbm'
      should_behave_as_key_value_store
    end
  end
end
