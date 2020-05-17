module CsvCop
  class Config
    def self.load(config)
      CsvCop::ConfigLoader.new(config).load
    end
  end
end