module Sirsi
  module LibraryRecord
    class << self

      def root_xpath
        'record'
      end

      # Map the name of the field to its xpath within the xml
      def fields_map
        {
          id: 'catalog/catalog_key',
          title: 'catalog/marc/marc_field[@tag="245"]'
        }
      end

      def to_solr(attributes)
        {
          'type_ssi' => 'library record',
          'repository_ssi' => 'Hull Local Studies Library',
          'id' => attributes[:id],
          'title_tesim' => attributes[:title]
        }
      end

    end
  end
end
