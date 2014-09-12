require_relative 'generic_record'

module Ead
  class SubSeries < GenericRecord
      class << self

        def root_xpath
          'c[@otherlevel="subseries"]'
        end

        def sub_collection_xpath
          "ancestor::#{Ead::SubCollection.root_xpath}[1]"
        end

        def series_xpath
          "ancestor::#{Ead::Series.root_xpath}[1]"
        end

        # Map the name of the field to its xpath within the EAD xml
        def fields_map
          super.merge({
            sub_collection_title: "#{sub_collection_xpath}/#{Ead::SubCollection.fields_map[:title]}",
            sub_collection_id: "#{sub_collection_xpath}/#{Ead::SubCollection.fields_map[:id]}",    
            series_title: "#{series_xpath}/#{Ead::Series.fields_map[:title]}",
            series_id: "#{series_xpath}/#{Ead::Series.fields_map[:id]}"
          })
        end

        def to_solr(attributes)
          super.merge({
            'type_ssi' => 'subseries',
            'format_ssi' =>'Archive Subseries',
            'display_title_ss' => display_title(attributes[:title]),
            'sub_collection_id_ssi' => format_id(attributes[:sub_collection_id]),
            'sub_collection_title_ss' => attributes[:sub_collection_title],
            'series_title_ss' => attributes[:series_title],
            'series_id_ssi' => format_id(attributes[:series_id])
          })
        end

        def display_title(title)
          "Archive Subseries: #{Array(title).first}"
        end

      end

  end
end
