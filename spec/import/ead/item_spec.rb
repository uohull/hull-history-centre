require 'spec_helper'
require_relative '../../../lib/import/ead/item'

describe Ead::Item do

  describe '.to_solr' do
    let(:id) { 'U DDH/14' }
    let(:title) { 'Photocopy. Revolutionary Communist Party' }

    it 'converts attributes to a hash of solr fields' do
      attributes = {id: id, title: title}
      solr_fields = Ead::Item.to_solr(attributes)
      expect(solr_fields['id']).to eq id
      expect(solr_fields['title_tesim']).to eq title
      expect(solr_fields['type_ssi']).to eq 'item'
    end
  end

end
