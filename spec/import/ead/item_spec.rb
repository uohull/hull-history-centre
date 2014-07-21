require 'spec_helper'
require_relative '../../../lib/import/ead/item'

describe Ead::Item do

  describe '.to_solr' do
    let(:id) { 'U DDH/14' }
    let(:title) { 'Photocopy. Revolutionary Communist Party' }
    let(:collection_id) { 'U DDH' }
    let(:collection_title) { 'Papers of Denzil Dean Harber' }
    let(:repo) { 'Hull University Archives' }

    it 'converts attributes to a hash of solr fields' do
      attributes = { id: id, title: title, collection_id: collection_id, collection_title: collection_title, repository: repo }
      solr_fields = Ead::Item.to_solr(attributes)

      expect(solr_fields['id']).to eq id
      expect(solr_fields['title_tesim']).to eq title
      expect(solr_fields['type_ssi']).to eq 'item'
      expect(solr_fields['collection_id_ss']).to eq collection_id
      expect(solr_fields['collection_title_ss']).to eq collection_title
      expect(solr_fields['repository_ssi']).to eq repo
    end
  end

end
