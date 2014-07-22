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
          print '.' if verbose
          attrs_for_record(item, record_class)
        end
      end

      # Get all the attributes for a single record
      def attrs_for_record(node, record_class)
        record_class.fields_map.inject({}) do |attrs, (field, xpath)|
          element = node.xpath("./#{xpath}")

          value = if element.children.length > 1
                    element.children.map(&:to_s)
                  else
                    text = element.text
                    text = text.strip if text
                  end

          attrs = attrs.merge(field => value)
        end
      end

      def verbose
        true
      end

    end
  end
end
