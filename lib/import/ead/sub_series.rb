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
            series_title: "#{series_xpath}/#{Ead::Series.fields_map[:title]}",
          })
        end

        def to_solr(attributes)
          super.merge({
            'type_ssi' => 'subseries',
            'format_ssi' =>'Archive Subseries',
            'display_title_ss' => display_title(attributes[:title]),
            'sub_collection_title_ss' => attributes[:sub_collection_title],
            'series_title_ss' => attributes[:series_title],
          })
        end

        def display_title(title)
          "Archive sub-series: #{Array(title).first}"
        end

      end

  end
end
