module Ead
  module Importer
    extend CommonImporterMethods

    def self.create_solr_docs_from_file_data(filename)
      errors = []
      objects = Ead::Parser.parse(filename)
      Array(objects[:collections]).each do |attributes|
        Blacklight.solr.add(Ead::Collection.to_solr(attributes))
      end
      Array(objects[:items]).each do |attributes|
        Blacklight.solr.add(Ead::Item.to_solr(attributes))
      end
      print_message "\nSaving records to solr"
      Blacklight.solr.commit
      errors
    rescue => e
      print_message(" ERROR: Import Aborted")
      errors << filename + ': ' + e.message
    end

  end
end
