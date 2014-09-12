require_relative 'generic_record'

module Ead
  class SubCollection < GenericRecord
    class << self 

      def root_xpath
        'c[@otherlevel="SubCollection"]'
      end

      def to_solr(attributes)
          super.merge({
            'type_ssi' => 'subcollection',
            'format_ssi' =>'Archive Subcollection',
            'display_title_ss' => display_title(attributes[:title]),
            'sub_collection_title_ss' => attributes[:sub_collection_title],
          })
        end

        def display_title(title)
          "Archive Subcollection: #{Array(title).first}"
        end

    end
  end
end
