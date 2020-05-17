require 'active_support/core_ext'
module CsvCop
  class Config
    def initialize(config)
      conf = CsvCop::ConfigLoader.new(config).load
      @config = conf.symbolize_keys
    end

    def read
      @config
    end

    def header?
      @config[:AllCops][:Header]
    end
  end
end