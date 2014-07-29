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
          title: 'catalog/marc/marc_field[@tag="245"]',
          format: 'catalog/item_record/cat1',
          subject: 'catalog/marc/marc_field[@tag="650"]'
        }
      end

      def to_solr(attributes)
        {
          'type_ssi' => 'library_record',
          'repository_ssi' => 'Hull Local Studies Library',
          'id' => attributes[:id],
          'title_tesim' => attributes[:title],
          'format_ssi' => transformed_format(attributes[:format]),
          'subject_ssim' => attributes[:subject],
          'subject_tesim' => attributes[:subject]
        }
      end

      def transformed_format(raw_data_format)
        data = raw_data_format.upcase if raw_data_format
        format_map.fetch(data, raw_data_format)
      end

      # TODO: Fill in format_map values or delete the ones
      # that aren't needed.

      # Keys are how the format appears in the SIRSI xml.
      # Values are how the format appears in blacklight facets.
      def format_map
        {
#          "AFCAS" => '?',
          "AFHDBK" => 'Book',
#          "AFLPTHDBK" => '?',
#          "AFLPTPBK" => '?',
          "AFPBK" => 'Book',
#          "ANFCAS" => '?',
          "ANFHBK" => 'Book',
#          "ANFLPTHDBK" => '?',
#          "ANFLPTPBK" => '?',
          "ANFPBK" => 'Book',
#          "AVEQUIP" => '?',
          "CD" => 'DVD',
          "CDROM" => 'DVD',
          "CFHBK" => 'Book',
          "CFPBK" => 'Book',
          "CNFHBK" => 'Book',
          "CNFPBK" => 'Book',
          "DVD" => 'DVD',
#          "FOREIGNF" => '?',
#          "LARGEPRINT" => '?',
          "MAGAZINE" => 'Book',
          "MAP" => 'Map',
          "MICROFORM" => 'Microfilm',
#          "NEWSPAPER" => '?',
#          "PAMPHLARGE" => '?',
#          "PAMPHSMALL" => '?',
#          "PICBK" => '?',
#          "RESOURCE" => '?',
#          "TEENFPBK" => '?',
#          "TKBKADCAS" => '?',
#          "TKBKADCD" => '?',
#          "UNKNOWN" => '?',
          "VIDEO" => 'Video'
        }
      end

    end
  end
end
