module Sirsi
  module Importer
    extend CommonImporterMethods

    def self.create_solr_docs_from_file_data(filename)
      objects = Sirsi::Parser.parse(filename)
      objects[:library_records].each do |attributes|
        Blacklight.solr.add(Sirsi::LibraryRecord.to_solr(attributes))
      end
      Blacklight.solr.commit
    end

  end
end
