require 'nokogiri'

module Ead
  module Parser
    class << self

      def parse(file)
        ead_data = File.read(file)
        doc = Nokogiri::XML(ead_data)
        { items: parse_items(doc) }
      end

      def parse_items(node)
        item_nodes = node.xpath("//#{Ead::Item.root_xpath}")
        item_nodes.map {|item| single_item(item) }
      end

      # Get all the attributes for a single Item
      def single_item(node)
        Ead::Item.fields_map.inject({}) do |attrs, (field, xpath)|
          value = node.xpath("./#{xpath}").text
        value = value.strip if value
        attrs = attrs.merge(field => value)
        end
      end

    end
  end
end
