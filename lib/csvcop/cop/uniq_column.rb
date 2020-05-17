module CsvCop
  module Cop
    module Lint
      class UniqColumn < Cop
        MSG = 'Column is must uniq element.'

        def initialize(csv, config)
          @csv = csv
          @config = config
        end

        def run
          on_ensure
        end

        private

        def on_ensure
          msg = ""
          by_col_csv = @csv.by_col
          by_col_csv.each_with_index do | col, col_index |
            uniq_col = col.flatten.map{|v| v.to_s}.uniq
            col = strize_values(col.flatten)
            
            uniq_col.each do | uniq_col_row | 
              if col.count(uniq_col_row) > 1
                msg.concat("column number:#{col_index}, #{uniq_col_row} is deplicated.\n")
              end
            end
          end

          unless msg.empty?
            return "ununiqness element.\n#{msg}"
          end

          false
        end

        def strize_values(array)
          array.map{|v| v.to_s}
        end
      end
    end
  end
end
