require 'rails_helper'
require_relative '../../../lib/import/ead'

describe Ead::Importer do
  let(:fixtures_path) { File.expand_path(File.join('spec', 'fixtures', 'sample_ead_files')) }
  let(:ead_file) { File.join(fixtures_path, 'U_DDH.xml') }

  before do
    allow(Ead::Importer).to receive(:verbose) { false }
    allow(Ead::Parser).to receive(:verbose) { false }
  end

  describe '.import' do
    it "imports the correct number of items" do
      Blacklight.solr.delete_by_query('*:*', params: {commit: true})
      Ead::Importer.import([ead_file])

      num_of_items = Blacklight.solr.select(params: {'q' => "type_ssi:item"})['response']['numFound']
      num_of_collections = Blacklight.solr.select(params: {'q' => "type_ssi:collection"})['response']['numFound']

      expect(num_of_items).to eq 14
      expect(num_of_collections).to eq 1
    end

    it "imports items correctly" do
      Ead::Importer.import([ead_file])
      doc = Blacklight.solr.select(params: {'q' => 'id:"U DDH/1"'})['response']['docs'].first
      expect(doc['id']).to eq "U DDH/1"
      expect(doc['title_tesim']).to eq ["Photocopy of file '1932 - 38'"]
    end

    it "imports collections correctly" do
      Ead::Importer.import([ead_file])
      doc = Blacklight.solr.select(params: {'q' => 'id:"U DDH"'})['response']['docs'].first
      expect(doc['id']).to eq "U DDH"
      expect(doc['title_tesim']).to eq ['Papers of Denzil Dean Harber']
    end
  end

  describe '.import with errors' do
    let(:first_file) { ead_file }
    let(:second_file) { File.join(fixtures_path, 'U_DAR_single_item.xml') }

    context 'when one file fails during import' do
      it 'continues importing the other files in the list' do
        expect(Ead::Parser).to receive(:parse).ordered.with(first_file).and_raise(StandardError.new('problem with file'))
        expect(Ead::Parser).to receive(:parse).ordered.with(second_file) { {} }
        Ead::Importer.import([first_file, second_file])
      end

      it 'returns the error messages' do
        expect(Ead::Parser).to receive(:parse).ordered.with(first_file).and_raise(StandardError.new('problem with file'))
        expect(Ead::Parser).to receive(:parse).ordered.with(second_file) { {} }
        errors = Ead::Importer.import([first_file, second_file])
        expect(errors).to eq ["#{first_file}: problem with file"]
      end
    end
  end

end
