module CommonImporterMethods

  def import(filenames)
    errors = []
    with_timing do
      files = Array(filenames)
      file_count = files.length

      files.each_with_index do |filename, i|
        print_message "\nImporting file #{i+1} of #{file_count}: #{filename}"
        errors << create_solr_docs_from_file_data(filename)
      end
    end
    errors = errors.flatten.compact
  end

  def with_timing &blk
    start_time = Time.now
    yield
    end_time = Time.now
    print_message "\nImport finished in: #{(end_time - start_time).ceil} seconds."
  end

  def print_message(msg)
    puts msg if verbose
  end

  def verbose
    true
  end

end
