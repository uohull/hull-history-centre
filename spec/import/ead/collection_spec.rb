require 'spec_helper'
require_relative '../../../lib/import/ead/collection'

describe Ead::Collection do
  describe '.to_solr' do
    let(:id) { 'U DDH' }
    let(:title) { 'Papers of Denzil Dean Harber' }
    let(:repo) { 'Hull University Archives' }
    let(:dates) { ['1932-1938'] }
    let(:extent) { '1 item' }
    let(:access) { ['<p>acc 1</p>' '<p>acc 2</p>'] }
    let(:cust) { ['<p>cust 1</p>' '<p>cust 2</p>'] }

    it 'converts attributes to a hash of solr fields' do
      attributes = { id: id, title: title, repository: repo,
                     dates: dates, extent: extent,
                     access: access, custodial_history: cust }
      solr_fields = Ead::Collection.to_solr(attributes)
      expect(solr_fields['type_ssi']).to eq 'collection'
      expect(solr_fields['id']).to eq id
      expect(solr_fields['title_tesim']).to eq title
      expect(solr_fields['repository_ssi']).to eq repo
      expect(solr_fields['format_ssi']).to eq 'Archive Collection'
      expect(solr_fields['dates_ssim']).to eq dates
      expect(solr_fields['extent_ss']).to eq '1 item'
      expect(solr_fields['access_ssim']).to eq access
      expect(solr_fields['custodial_history_ssim']).to eq cust
    end
  end
end
