require "yaml"
require "pathname"

module CsvCop
  class ConfigNotFoundError < Error ; end

  class ConfigLoader
    DOTFILE = '.csvcop.yml'
    CSVCOP_HOME = File.realpath(File.join(File.dirname(__FILE__), '..', '..'))
    DEFAULT_FILE = File.join(CSVCOP_HOME, 'config', 'default.yml')

    def initialize(rule_file_path)
      unless rule_file_path.nil?
        raise ConfigNotFoundError unless File.exist?(rule_file_path)
        @original_rule = YAML.load_file(rule_file_path)
      end
      @rule = YAML.load_file(DEFAULT_FILE)
    end
    
    def load
      return @rule if @original_rule.nil?
      merge_yaml(@rule, @original_rule)
    end

    private
    
    def merge_yaml(yaml1, yaml2)
      yaml2.each do |k, v|
        if v.class == Hash && yaml1.key?(k)
          yaml1[k] = merge_yaml(yaml1[k], v)
        else
          yaml1[k] = v
        end
      end
      return yaml1
    end
  end
end