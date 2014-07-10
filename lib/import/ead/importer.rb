module Ead
  module Importer
    class << self

      def import(filenames)
        Array(filenames).each do |filename|
          objects = Ead::Parser.parse(filename)
          objects[:items].each do |attributes|
            Blacklight.solr.add(Ead::Item.to_solr(attributes))
          end
          objects[:collections].each do |attributes|
            Blacklight.solr.add(Ead::Collection.to_solr(attributes))
          end
          Blacklight.solr.commit
        end
      end

    end
  end
end
