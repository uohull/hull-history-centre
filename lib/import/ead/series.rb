module Ead
  module Series
    class << self

      def root_xpath
        'c[@level = "series"]'
      end

      # Map the name of the field to its xpath within the EAD xml
      def fields_map
        { title: 'did/unittitle' }
      end

    end
  end
end
