require 'rails_helper'
require 'import/ead'

feature 'Searching within a collection:' do
  let(:fixtures_path) { File.expand_path(File.join('spec', 'fixtures', 'sample_sirsi_files')) }
  let(:single_file) { File.join(fixtures_path, 'single_sirsi_record.xml') }
  let(:full_file) { File.join(fixtures_path, 'full_record_sample.xml') }


  before do
    Blacklight.solr.delete_by_query("*:*", params: { commit: true })
    allow(Sirsi::Parser).to receive(:verbose) { false }
    allow(Sirsi::Importer).to receive(:verbose) { false }
    Sirsi::Importer.import([single_file, full_file])
  end

  scenario 'viewing a library record held at Hull Local Studies Library' do
    visit catalogue_path(id: "1667917") 
    expect(page).to have_link("Check if this item can be borrowed") 
  end
  
end