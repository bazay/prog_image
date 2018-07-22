require 'pathname'

module ProgImage
  class << self
    def env
      @env ||= ENV['RACK_ENV'] || 'development'
    end

    def root
      Pathname.new File.dirname(File.expand_path(__dir__))
    end

    def version
      @version ||= File.read(ProgImage.root.join('VERSION')).chomp.freeze
    end
  end
end
