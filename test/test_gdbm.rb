# encoding: utf-8

require 'helper'
require 'shkuph/gdbm'

class Shkuph::TestGDBM < MiniTest::Unit::TestCase
  context 'Shkuph GDBM Adapter' do
    setup do
      @gdbm = Shkuph::GDBM.new('test.gdbm',
        :options => { :mode => :manage },
        :key_marshal => Marshal,
        :value_marshal => Marshal)
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
