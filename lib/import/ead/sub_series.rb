module Ead
  module SubSeries
    class << self

      def root_xpath
        'c[@otherlevel="subseries"]'
      end

      # Map the name of the field to its xpath within the EAD xml
      def fields_map
        { title: 'did/unittitle' }
      end

    end
  end
end
