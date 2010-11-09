# encoding: utf-8

require 'bundler/setup'

module Shkuph
  class UnsatisfiedDependency < StandardError; end
  module Adapters; end
end

require 'shkuph/version'
require 'shkuph/strategy'
require 'shkuph/storage'
