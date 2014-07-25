module Ead
  module Importer
    extend CommonImporterMethods

    def self.create_solr_docs_from_file_data(filename)
      objects = Ead::Parser.parse(filename)
      objects[:collections].each do |attributes|
        Blacklight.solr.add(Ead::Collection.to_solr(attributes))
      end
      objects[:items].each do |attributes|
        Blacklight.solr.add(Ead::Item.to_solr(attributes))
      end
      Blacklight.solr.commit
    end

  end
end
