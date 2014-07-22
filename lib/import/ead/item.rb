module Ead
  module Item
    class << self

      def root_xpath
        'c[@level = "item"]'
      end

      # The xpath to the collection that the item belongs to
      # (relative path from the item node)
      def collection_xpath
        "ancestor::#{Ead::Collection.root_xpath}[1]"
      end

      # Map the name of the field to its xpath within the EAD xml
      def fields_map
        {
          id: 'did/unitid[@label = "Reference"]',
          title: 'did/unittitle',
          collection_id: "#{collection_xpath}/#{Ead::Collection.fields_map[:id]}",
          collection_title: "#{collection_xpath}/#{Ead::Collection.fields_map[:title]}",
          repository: 'did/repository',
          extent: 'did/physdesc/extent',
        }
      end

      def to_solr(attributes)
        {
          'id' => attributes[:id],
          'type_ssi' => 'item',
          'title_tesim' => attributes[:title],
          'collection_id_ss' => attributes[:collection_id],
          'collection_title_ss' => attributes[:collection_title],
          'repository_ssi' => attributes[:repository],
          'format_ssi' => 'Archive Item',
          'extent_ss' => attributes[:extent]
        }
      end
    end
  end
end
