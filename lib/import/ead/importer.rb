module Ead
  module Importer
    class << self

      def import(filenames)
        with_timing do
          files = Array(filenames)
          file_count = files.length

          files.each_with_index do |filename, i|
            print_message "\nImporting file #{i+1} of #{file_count}: #{filename}"
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

      def print_message(msg)
        puts msg if verbose
      end

      def with_timing &blk
        start_time = Time.now
        yield
        end_time = Time.now
        print_message "\nImport finished in: #{(end_time - start_time).ceil} seconds."
      end

      def verbose
        true
      end

    end  # class << self
  end
end
