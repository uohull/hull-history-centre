require 'nokogiri'

class EadParser

  def self.parse(file)
    ead_data = File.read(file)
    doc = Nokogiri::XML(ead_data)
    { items: parse_items(doc) }
  end

  def self.parse_items(node)
    item_nodes = node.xpath("//#{item_node_map[:root]}")
    item_nodes.map {|item| single_item(item) }
  end

  def self.single_item(node)
    item_fields.inject({}) do |attrs, field|
      value = node.xpath("./#{item_node_map[field]}").text
      value = value.strip if value
      attrs = attrs.merge(field => value)
    end
  end

  def self.item_node_map
    { root: 'c[@level = "item"]',
      id: 'did/unitid[@label = "Reference"]',
      title: 'did/unittitle'
    }
  end

  def self.item_fields
    item_node_map.reject {|k,v| k == :root }.keys
  end

end
