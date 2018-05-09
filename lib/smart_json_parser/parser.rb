require "json"

module SmartJsonParser
  class Parser
    attr_reader :path

    InvalidAttributes = Class.new(StandardError)

    def initialize(path)
      @path = path
    end

    def get(attributes)
      validate_attributes(attributes)
      attr_arry = attributes.split(',') if !attributes.class == Array

      file = File.read(path)
      json_object = JSON.parse(file)

      puts json_object
    end

    def validate_attributes(attributes)
      raise InvalidAttributes, "incorrect parameter format" unless [String, Array].includes?(attributes)
    end
  end
end