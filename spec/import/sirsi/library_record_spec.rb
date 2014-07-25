require 'spec_helper'
require_relative '../../../lib/import/sirsi/library_record'

describe Sirsi::LibraryRecord do

  describe '.to_solr' do
    let(:id) { '123' }
    let(:title) { 'my title' }

    let(:attrs) { { id: id, title: title } }

    it 'converts attributes to a hash of solr fields' do
      solr_fields = Sirsi::LibraryRecord.to_solr(attrs)
      expect(solr_fields['type_ssi']).to eq 'library_record'
      expect(solr_fields['id']).to eq id
      expect(solr_fields['title_tesim']).to eq title
      expect(solr_fields['repository_ssi']).to eq 'Hull Local Studies Library'
    end
  end

  describe 'format' do
    it 'standardizes the format' do
      solr_doc = Sirsi::LibraryRecord.to_solr(format: nil)
      expect(solr_doc['format_ssi']).to be_nil
      solr_doc = Sirsi::LibraryRecord.to_solr(format: 'CFHBK')
      expect(solr_doc['format_ssi']).to eq 'Book'
      solr_doc = Sirsi::LibraryRecord.to_solr(format: 'Something unexpected')
      expect(solr_doc['format_ssi']).to eq 'Something unexpected'
    end
  end

end

