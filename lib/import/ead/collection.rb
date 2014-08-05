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
          dates: 'did/unitdate',
          extent: 'did/physdesc/extent',
          access: 'accessrestrict',
          custodial_history: 'custodhist',
          language: 'did/langmaterial/language',
          biog_hist: 'bioghist',
          description: 'scopecontent',
          arrangement: 'arrangement',
          related: 'relatedmaterial',
          pub_notes: 'bibliography/bibref'
        }
      end

      def to_solr(attributes)
        {
          'id' => attributes[:id],
          'type_ssi' => 'collection',
          'format_ssi' => 'Archive Collection',
          'title_tesim' => attributes[:title],
          'display_title_ss' => display_title(attributes[:title]),
          'repository_ssi' => attributes[:repository],
          'dates_ssim' => attributes[:dates],
          'extent_ssm' => attributes[:extent],
          'access_ssim' => attributes[:access],
          'custodial_history_ssim' => attributes[:custodial_history],
          'language_ssim' => attributes[:language],
          'biog_hist_ssm' => attributes[:biog_hist],
          'description_ssim' => attributes[:description],
          'arrangement_ssm' => attributes[:arrangement],
          'related_ssm' => attributes[:related],
          'pub_notes_ssm' => break_lines(attributes[:pub_notes])
        }
      end

      def display_title(title)
        "Archive Collection: #{Array(title).first}"
      end

      def break_lines(raw_data)
        raw_data.gsub("\n", '<br />')
      end

    end
  end
end
