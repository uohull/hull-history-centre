require 'spec_helper'
require_relative '../../../lib/import/ead/collection'

describe Ead::Collection do
  describe '.to_solr' do
    let(:id) { 'U DDH' }
    let(:title) { 'Papers of Denzil Dean Harber' }
    let(:repo) { 'Hull University Archives' }
    let(:dates) { ['1932-1938'] }

    it 'converts attributes to a hash of solr fields' do
      attributes = { id: id, title: title, repository: repo,
                     dates: dates }
      solr_fields = Ead::Collection.to_solr(attributes)
      expect(solr_fields['type_ssi']).to eq 'collection'
      expect(solr_fields['id']).to eq id
      expect(solr_fields['title_tesim']).to eq title
      expect(solr_fields['repository_ssi']).to eq repo
      expect(solr_fields['format_ssi']).to eq 'Archive Collection'
      expect(solr_fields['dates_ssim']).to eq dates
    end
  end
end
