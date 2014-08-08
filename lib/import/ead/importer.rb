module Ead
  module Importer
    extend CommonImporterMethods

    def self.create_solr_docs_from_file_data(filename)
      errors = []
      objects = Ead::Parser.parse(filename)

      map_key_to_class = { collections: Ead::Collection,
                           items:       Ead::Item,
                           pieces:      Ead::Piece }

      print_message "\nSaving records to solr"
      map_key_to_class.each do |key, ead_class|
        Array(objects[key]).each do |attributes|
          Blacklight.solr.add(ead_class.to_solr(attributes))
        end
        Blacklight.solr.commit
      end

      errors
    rescue => e
      print_message(" ERROR: Import Aborted")
      errors << filename + ': ' + e.message
    end

  end
end
