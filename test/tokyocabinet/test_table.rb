# encoding: utf-8

require 'helper'
require 'shkuph/tokyocabinet/table'

class Shkuph::TokyoCabinet::TestTable < MiniTest::Unit::TestCase
  context 'Shkuph TokyoCabinet Table Database' do
    setup do
      @tct = Shkuph::TokyoCabinet::Table.new('test.tct',
        :options => { :mode => :manage },
        :key_marshal => Marshal)
    end

    teardown do
      @tct.close
      FileUtils.rm_f 'test.tct'
    end

    subject { @tct }

    should 'get and set rows' do
      row = { 'a' => '1', 'b' => '666' }

      subject['test'] = row
      assert_equal row, subject['test']
    end

    if ENV['SHKUPH_TEST'].nil? || ENV['SHKUPH_TEST'] == 'tct'
      #should_behave_as_key_value_store
    end
  end
end
