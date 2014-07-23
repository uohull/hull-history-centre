module Ead
  module Collection
    class << self

      def root_xpath
        'archdesc'
      end

      # Map the name of the field to its xpath within the EAD xml
      def fields_map
        {
          id: 'did/unitid[@label = "Reference"]',
          title: 'did/unittitle',
          repository: "did/repository"
        }
      end

      def to_solr(attributes)
        {
          'id' => attributes[:id],
          'type_ssi' => 'collection',
          'title_tesim' => attributes[:title],
          'repository_ssi' => attributes[:repository],
          'format_ssi' => 'Archive Collection'
        }
      end

    end
  end
end
