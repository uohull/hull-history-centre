require 'spec_helper'
require_relative '../../../lib/import/sirsi/library_record'

describe Sirsi::LibraryRecord do
  describe '.to_solr' do
    let(:id) { '123' }
    let(:title) { 'my title' }

    let(:attrs) { { id: id, title: title } }

    it 'converts attributes to a hash of solr fields' do
      solr_fields = Sirsi::LibraryRecord.to_solr(attrs)
      expect(solr_fields['type_ssi']).to eq 'library record'
      expect(solr_fields['id']).to eq id
      expect(solr_fields['title_tesim']).to eq title
    end
  end
end

