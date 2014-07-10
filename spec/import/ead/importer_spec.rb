require 'rails_helper'
require_relative '../../../lib/import/ead'

describe Ead::Importer do
  let(:fixtures_path) { File.expand_path(File.join('spec', 'fixtures', 'sample_ead_files')) }
  let(:ead_file) { File.join(fixtures_path, 'U_DDH.xml') }

  describe '.import' do
    it "imports the correct number of items" do
      Blacklight.solr.delete_by_query('*:*', params: {commit: true})
      Ead::Importer.import([ead_file])
      expect(Blacklight.solr.select(params: {'q' => "*:*"})['response']['numFound']).to eq 14
    end

    it "imports items correctly" do
      Ead::Importer.import([ead_file])
      doc = Blacklight.solr.select(params: {'q' => 'id:"U DDH/1"'})['response']['docs'].first
      expect(doc['id']).to eq "U DDH/1"
      expect(doc['title_tesim']).to eq ["Photocopy of file '1932 - 38'"]
    end
  end

end
