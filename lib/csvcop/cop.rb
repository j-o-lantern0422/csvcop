module CsvCop
  module Cop
    class CopError < Error ; end

    class Cop
      def initialize(csv, config)
        @csv = csv
        @config = config
        @cops = [
          CsvCop::Cop::Lint::UniqColumn.new(@csv, @config)
        ]
        @msg = "CsvCop ensure offences.\n"
      end

      def on_ensure_all
        @cops.each do | cop | 
          result = cop.run
          
          if result
            @msg.concat(result)
          end
        end

        puts @msg
      end
    end
  end
end