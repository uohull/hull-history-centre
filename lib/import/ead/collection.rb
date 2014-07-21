module Ead
  module Collection
    class << self

      def root_xpath
        'archdesc'
      end

      # The xpath to the <eadheader> node
      # (relative path from the collection node)
      def ead_header_xpath
        'ancestor::ead[1]/eadheader'
      end

      # Map the name of the field to its xpath within the EAD xml
      def fields_map
        {
          id: 'did/unitid[@label = "Reference"]',
          title: 'did/unittitle',
          repository: "#{ead_header_xpath}/filedesc/titlestmt/author"
        }
      end

      def to_solr(attributes)
        {
          'id' => attributes[:id],
          'type_ssi' => 'collection',
          'title_tesim' => attributes[:title],
          'repository_ssi' => attributes[:repository]
        }
      end

    end
  end
end
