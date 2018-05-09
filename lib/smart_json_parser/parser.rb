require "json"

module SmartJsonParser
  class Parser
    attr_reader :path, :json_object

    InvalidAttributes = Class.new(StandardError)

    DEFAULT_ATTRS = ["data.attributes.contact-number",
      "data.attributes.email-address",
      "data.attributes.title+first-name+last-name",
      "included.products.attributes.name"
    ].freeze

    def initialize(path)
      @path = path
      file = File.read(path)
      @json_object = JSON.parse(file, object_class: OpenStruct)
    end

    def get(attribute)
      validate_attribute(attribute)

      attr_arry = attribute
      attr_arry = attribute.split(',') if attribute.class != Array

      parse(attr_arry)
    end

    def get_default
      parse(DEFAULT_ATTRS)      
    end

    private

    def parse(attrs)
      final_result = []

      attrs.each do |attr_path|
        attr_arry = attr_path.split('.')
        
        current_path_data = json_object[attr_arry[0]]

        if current_path_data.class == Array
          current_path_data = current_path_data.find { |obj| obj.type == attr_arry[1] }
          attr_arry.delete_at(attr_arry.index(attr_arry[1]))
        end

        attr_arry[1...attr_arry.length].each_with_index do |attr_name, index|
          if index == attr_arry.length - 2  && attr_name.index("+") != nil
            concat_attr_arry = attr_name.split('+')
            final_concat_value = []

            concat_attr_arry.each do |final_name|
              final_concat_value << current_path_data[final_name]
            end

            current_path_data = final_concat_value.join(" ")            
          else
            validate_parent_attribute_name(attr_name)
            current_path_data = current_path_data[attr_name]
          end
        end

        if current_path_data.class == OpenStruct
          final_result << current_path_data.to_h
        else
          final_result << current_path_data
        end
      end

      final_result
    end

    def validate_attribute(attribute)
      raise InvalidAttributes, "incorrect parameter format" unless [String, Array].include?(attribute.class)
    end

    def validate_parent_attribute_name(name)
      raise InvalidAttributes, "parent attributes cant have + operator" if name.index("+") != nil
    end
  end
end