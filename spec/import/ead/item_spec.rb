require 'spec_helper'
require_relative '../../../lib/import/ead/item'

describe Ead::Item do

  describe '.to_solr' do
    let(:id) { 'U DDH/14' }
    let(:title) { 'Photocopy. Revolutionary Communist Party' }
    let(:collection_id) { 'U DDH' }
    let(:collection_title) { 'Papers of Denzil Dean Harber' }
    let(:repo) { 'Hull University Archives' }
    let(:extent) { '1 item' }
    let(:access) { ['<p>acc 1</p>' '<p>acc 2</p>'] }
    let(:desc) { ['<p>desc 1</p>' '<p>desc 2</p>'] }

    it 'converts attributes to a hash of solr fields' do
      attributes = { id: id, title: title, collection_id: collection_id, collection_title: collection_title, repository: repo, extent: extent, access: access, description: desc }
      solr_fields = Ead::Item.to_solr(attributes)

      expect(solr_fields['id']).to eq id
      expect(solr_fields['title_tesim']).to eq title
      expect(solr_fields['type_ssi']).to eq 'item'
      expect(solr_fields['collection_id_ss']).to eq collection_id
      expect(solr_fields['collection_title_ss']).to eq collection_title
      expect(solr_fields['repository_ssi']).to eq repo
      expect(solr_fields['format_ssi']).to eq 'Archive Item'
      expect(solr_fields['extent_ss']).to eq '1 item'
      expect(solr_fields['access_ssim']).to eq access
      expect(solr_fields['description_tesim']).to eq desc
    end
  end

end
