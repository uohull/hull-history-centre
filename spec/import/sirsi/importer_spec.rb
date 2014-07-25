require 'rails_helper'
require_relative '../../../lib/import/sirsi'

describe Sirsi::Importer do
  let(:fixtures_path) { File.expand_path(File.join('spec', 'fixtures', 'sample_sirsi_files')) }
  let(:sirsi_file) { File.join(fixtures_path, 'full_record_sample.xml') }

  before do
    allow(Sirsi::Importer).to receive(:verbose) { false }
    allow(Sirsi::Parser).to receive(:verbose) { false }
  end

  describe '.import' do
    it 'imports the records into solr documents' do
      Blacklight.solr.delete_by_query('*:*', params: {commit: true})
      Sirsi::Importer.import([sirsi_file])
      count = Blacklight.solr.select(params: {'q' => 'type_ssi:"library record"'})['response']['numFound']
      expect(count).to eq 3

      doc = Blacklight.solr.select(params: {'q' => 'title_tesim:"Country ballads"'})['response']['docs'].first
      expect(doc['id']).to eq '1667617'
    end
  end
end
