require 'nokogiri'

class EadParser

  def self.parse(file)
    ead_data = File.read(file)
    doc = Nokogiri::XML(ead_data)
    { items: parse_items(doc) }
  end

  def self.parse_items(node)
    item_nodes = node.xpath("//#{Ead::Item.root_xpath}")
    item_nodes.map {|item| single_item(item) }
  end

  def self.single_item(node)
    Ead::Item.fields_map.inject({}) do |attrs, field_map|
      field = field_map.first
      xpath = field_map.last

      value = node.xpath("./#{xpath}").text
      value = value.strip if value
      attrs = attrs.merge(field => value)
    end
  end

end
