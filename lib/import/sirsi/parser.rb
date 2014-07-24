require 'nokogiri'

module Sirsi
  module Parser
    class << self

      # Get all the attributes for a single record
      def attrs_for_record(node, record_class)
        record_class.fields_map.inject({}) do |attrs, (field, xpath)|
          element = node.xpath("./#{xpath}")
          value = element.text
          value = value.strip if value
          attrs = attrs.merge(field => value)
        end
      end

    end
  end
end
