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

      def sub_collection_xpath
        "ancestor::#{Ead::SubCollection.root_xpath}[1]"
      end

      def series_xpath
        "ancestor::#{Ead::Series.root_xpath}[1]"
      end

      def sub_series_xpath
        "ancestor::#{Ead::SubSeries.root_xpath}[1]"
      end

      # Map the name of the field to its xpath within the EAD xml
      def fields_map
        {
          id: 'did/unitid[@label = "Reference"]',
          title: 'did/unittitle',
          repository: 'did/repository',
          extent: 'did/physdesc/extent',
          access: 'accessrestrict',
          description: 'scopecontent',
          dates: 'did/unitdate',
          collection_id: "#{collection_xpath}/#{Ead::Collection.fields_map[:id]}",
          collection_title: "#{collection_xpath}/#{Ead::Collection.fields_map[:title]}",
          sub_collection_title: "#{sub_collection_xpath}/#{Ead::SubCollection.fields_map[:title]}",
          series_title: "#{series_xpath}/#{Ead::Series.fields_map[:title]}",
          sub_series_title: "#{sub_series_xpath}/#{Ead::SubSeries.fields_map[:title]}",
        }
      end

      def to_solr(attributes)
        {
          'id' => attributes[:id],
          'type_ssi' => 'item',
          'format_ssi' => 'Archive Item',
          'title_tesim' => attributes[:title],
          'display_title_ss' => display_title(attributes[:title]),
          'repository_ssi' => attributes[:repository],
          'extent_ssm' => attributes[:extent],
          'access_ssim' => attributes[:access],
          'description_tesim' => attributes[:description],
          'dates_ssim' => attributes[:dates],
          'collection_id_ssi' => attributes[:collection_id],
          'collection_title_ss' => attributes[:collection_title],
          'sub_collection_title_ss' => attributes[:sub_collection_title],
          'series_title_ss' => attributes[:series_title],
          'sub_series_title_ss' => attributes[:sub_series_title]
        }
      end

      def display_title(title)
        "Archive Item: #{Array(title).first}"
      end

    end
  end
end
