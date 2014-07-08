require 'rails_helper'

describe Item do

  describe 'attributes' do
    it 'has a list of all possible item attributes' do
      expect(Item::ATTRIBUTES).to include(:id)
      expect(Item::ATTRIBUTES).to include(:title)
    end

    it 'has getters and setters for the attributes' do
      item = Item.new
      expect(item.respond_to?(:id)).to eq true
      expect(item.respond_to?(:id=)).to eq true
      expect(item.respond_to?(:title)).to eq true
      expect(item.respond_to?(:title=)).to eq true
    end
  end

  describe '#to_solr' do
    let(:id) { 'U DDH/14' }
    let(:title) { 'Photocopy. Revolutionary Communist Party' }
    let(:item) { Item.new(id: id, title: title) }

    it 'converts attributes to a hash of solr fields' do
      solr_fields = item.to_solr
      expect(solr_fields['id']).to eq id
      expect(solr_fields['title_tesim']).to eq title
    end
  end

end
