require 'nokogiri'

module Ead
  module Parser
    class << self

      def parse(file)
        ead_data = File.read(file)
        doc = Nokogiri::XML(ead_data)
        {
          items: parse_records(doc, Ead::Item),
          collections: parse_records(doc, Ead::Collection),
        }
      end

      def parse_records(node, record_class)
        nodes = node.xpath("//#{record_class.root_xpath}")
        nodes.map do |item|
          print '.' unless Rails.env == 'test'
          attrs_for_record(item, record_class)
        end
      end

      # Get all the attributes for a single record
      def attrs_for_record(node, record_class)
        record_class.fields_map.inject({}) do |attrs, (field, xpath)|
          value = node.xpath("./#{xpath}").text
          value = value.strip if value
          attrs = attrs.merge(field => value)
        end
      end

    end
  end
end
