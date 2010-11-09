# encoding: utf-8

module Shkuph
  # Myaso version information.
  # Using Semantic Version (http://semver.org/) specification.
  module Version
    class << self
      # Root path of the Shkuph gem.
      #
      # ==== Returns
      # String:: Shkuph gem root path.
      #
      def root
        @@shkuph_root ||= File.expand_path('../../../', __FILE__)
      end

      # Shkuph gem version according to VERSION file.
      #
      # ==== Returns
      # String:: Shkuph semantic version.
      #
      def to_s
        @@version ||= File.read(File.join(Shkuph::Version.root, 'VERSION')).chomp
      end
    end
  end
end
