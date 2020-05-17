require "csvcop"
require "thor"

module CsvCop
  class Cli < Thor
    desc "csvcop {CSV File Path} {options}", "check csv file"
    option "config", aliases: "-c", type: :string
    def csvcop(csv_file_path)
      rule = CsvCop::Config.load(options[:config])
      puts rule
    end  
  end
end
