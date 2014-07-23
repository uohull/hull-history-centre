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
          repository: "did/repository",
          dates: 'did/unitdate'
        }
      end

      def to_solr(attributes)
        {
          'id' => attributes[:id],
          'type_ssi' => 'collection',
          'format_ssi' => 'Archive Collection',
          'title_tesim' => attributes[:title],
          'repository_ssi' => attributes[:repository],
          'dates_ssim' => attributes[:dates],
        }
      end

    end
  end
end
