# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

#require 'rspec/core/rake_task'
#RSpec::Core::RakeTask.new(:spec)
task :default => []; Rake::Task[:default].clear

ZIP_URL = "https://github.com/projectblacklight/blacklight-jetty/archive/v4.6.0.zip"
require 'jettywrapper'

task ci: ['jetty:clean', :configure_jetty] do
  ENV['environment'] = "test"
  jetty_params = Jettywrapper.load_config
  jetty_params[:startup_wait]= 60

  Jettywrapper.wrap(jetty_params) do
    # run the tests
    Rake::Task["spec"].invoke
  end
end


task configure_jetty: :add_test_core do
  FileList['solr_conf/conf/*'].each do |f|
    cp("#{f}", 'jetty/solr/blacklight-core/conf/', :verbose => true)
  end
end

task :add_test_core do
  require 'nokogiri'
  FileUtils.mkdir_p('jetty/solr/test-core/conf')
  FileList['solr_conf/conf/*'].each do |f|
    cp("#{f}", 'jetty/solr/test-core/conf/', :verbose => true)
  end

  # add test-core to solr.xml
  file = File.read("jetty/solr/solr.xml")
  doc = Nokogiri::XML(file)
  blacklight = doc.at_css("core[name='blacklight-core']")
  test = blacklight.clone
  test['name'] = 'test'
  test['instanceDir'] = 'test-core'
  blacklight.add_next_sibling(test)
  File.open("jetty/solr/solr.xml", "w") do |f|
    f.write doc.to_xml
  end
end

task default: :ci
