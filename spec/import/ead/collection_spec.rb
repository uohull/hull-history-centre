require 'spec_helper'
require_relative '../../../lib/import/ead/collection'

describe Ead::Collection do
  describe '.to_solr' do
    let(:id) { 'U DDH' }
    let(:title) { 'Papers of Denzil Dean Harber' }
    let(:repo) { 'Hull University Archives' }

    it 'converts attributes to a hash of solr fields' do
      attributes = { id: id, title: title, repository: repo }
      solr_fields = Ead::Collection.to_solr(attributes)
      expect(solr_fields['id']).to eq id
      expect(solr_fields['title_tesim']).to eq title
      expect(solr_fields['type_ssi']).to eq 'collection'
      expect(solr_fields['repository_ssi']).to eq repo
    end
  end
end
