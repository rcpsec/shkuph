# encoding: utf-8

require 'helper'
require 'shkuph/tokyocabinet/hash'

class Shkuph::TokyoCabinet::TestHash < MiniTest::Unit::TestCase
  context 'Shkuph TokyoCabinet Hash Database' do
    setup do
      @tch = Shkuph::GDBM.new('test.tch',
        :options => { :mode => :manage },
        :key_marshal => Marshal,
        :value_marshal => Marshal)
    end

    teardown do
      @tch.close
      FileUtils.rm_f 'test.gdbm'
    end

    subject { @tch }

    if ENV['SHKUPH_TEST'].nil? || ENV['SHKUPH_TEST'] == 'tch'
      should_behave_as_key_value_store
    end
  end
end
