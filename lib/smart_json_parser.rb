require "smart_json_parser/version"
require "smart_json_parser/parser"

module SmartJsonParser
  def self.new(path)
    Parser.new(path)
  end
end
