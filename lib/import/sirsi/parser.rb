require 'nokogiri'

module Sirsi
  module Parser
    class << self

      def parse(file)
        sirsi_data = File.read(file)
        xml = Nokogiri::XML(sirsi_data)
        nodes = xml.xpath("//#{Sirsi::LibraryRecord.root_xpath}")
        records = nodes.map do |record|
          attrs_for_record(record, Sirsi::LibraryRecord)
        end

        { library_records: records }
      end

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
