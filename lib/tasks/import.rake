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
    Ead::Importer.import(files)
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
    Sirsi::Importer.import(files)
  end

end
