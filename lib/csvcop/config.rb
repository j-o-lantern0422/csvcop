require 'active_support/core_ext'
module CsvCop
  class Config
    def initialize(config=nil)
      conf = CsvCop::ConfigLoader.new(config).load
      @config = conf.deep_symbolize_keys
    end

    def read
      @config
    end

    def header?
      @config[:AllCops][:Header]
    end
  end
end