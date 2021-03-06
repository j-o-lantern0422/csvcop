module CsvCop
  module Cop
    module Lint
      class DeplicatedElementInOneColumn < Cop
        MSG = 'Column is must uniq element.'

        def initialize(csv, config)
          @csv = csv
          @config = config
        end

        def self.enable?(config)
          config[:AllCops][config_key][:Enable]
        end

        def self.config_key
          self.name.split("::").last.to_sym
        end

        def run
          return false unless DeplicatedElementInOneColumn.enable?(@config)
          on_ensure
        end

        private
        def on_ensure
          msg = ensure_deplicated_elementes
          unless msg.empty?
            return "ununiqness element.\n#{msg}"
          end

          false
        end

        def ensure_deplicated_elementes
          msg = ""
          by_col_csv = @csv.by_col
          by_col_csv.each_with_index do | col, col_index |
            uniq_col = col.flatten.map{|v| v.to_s}.uniq
            col = stringify_values(col.flatten)
            
            uniq_col.each do | uniq_col_row | 
              if col.count(uniq_col_row) > 1
                msg.concat("column number:#{col_index}, #{uniq_col_row} is deplicated.\n")
              end
            end
          end

          msg
        end

        def stringify_values(array)
          array.map{|v| v.to_s}
        end
      end
    end
  end
end
