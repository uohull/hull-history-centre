namespace :import do

  desc 'Import EAD data'
  task :ead => :environment do |t, args|
    require 'import/ead'

    files = Dir.glob(args.extras)

    files = files.map do |file|
      if File.directory?(file)
        match_xml = File.join(file, '*.xml')
        entries = Dir.glob(match_xml)
        entries
      else
        file
      end
    end

    files = files.flatten
    errors = Ead::Importer.import(files)

    unless errors.empty?
      puts "Import finished with the following errors: "
      errors.map {|e| puts "\n"; puts e }
    end
  end


  desc 'Import SIRSI data'
  task :sirsi => :environment do |t, args|
    require 'import/sirsi'

    files = Dir.glob(args.extras)

    files = files.map do |file|
      if File.directory?(file)
        match_xml = File.join(file, '*.xml')
        entries = Dir.glob(match_xml)
        entries
      else
        file
      end
    end

    files = files.flatten
    errors = Sirsi::Importer.import(files)

    unless errors.empty?
      puts "Import finished with the following errors: "
      errors.map {|e| puts "\n"; puts e }
    end
  end

end
