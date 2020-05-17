require "csvcop"
require "thor"
require "csv"

module CsvCop
  class Cli < Thor
    desc "csvcop {CSV File Path} {options}", "check csv file"
    option "config", aliases: "-c", type: :string
    def csvcop(csv_file_path)
      config = CsvCop::Config.new(options[:config]).read
      csv = CSV.table(csv_file_path)
      cop = CsvCop::Cop::Cop.new(csv, config)
      cop.on_ensure_all
    end  
  end
end
