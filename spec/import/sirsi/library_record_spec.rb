require 'spec_helper'
require_relative '../../../lib/import/sirsi/library_record'

describe Sirsi::LibraryRecord do
  let(:id) { '123' }
  let(:title) { 'my title' }
  let(:subject) { ['Slave-trade--Great Britain--Early works to 1800.', 'Antislavery movements--Great Britain.'] }
  let(:author_100) { 'Fawcett, Bill' }
  let(:author_110) { 'Great Britain. Parliament. House of Commons.' }
  let(:author_700) { ['Carro, Joannes de,', 'Poulson, George,'] }
  let(:author_710) { 'English Heritage.' }

  let(:attrs) { { id: id, title: title, subject: subject, author_100: author_100, author_110: author_110, author_700: author_700, author_710: author_710 } }

  describe '.to_solr' do
    it 'converts attributes to a hash of solr fields' do
      solr_fields = Sirsi::LibraryRecord.to_solr(attrs)
      expect(solr_fields['type_ssi']).to eq 'library_record'
      expect(solr_fields['id']).to eq id
      expect(solr_fields['title_tesim']).to eq title
      expect(solr_fields['repository_ssi']).to eq 'Hull Local Studies Library'
      expect(solr_fields['subject_ssim']).to eq ['Slave-trade--Great Britain--Early works to 1800.', 'Antislavery movements--Great Britain.']
      expect(solr_fields['subject_tesim']).to eq ['Slave-trade--Great Britain--Early works to 1800.', 'Antislavery movements--Great Britain.']
      expect(solr_fields['author_tesim']).to eq [author_100, author_700, author_110, author_710].flatten
    end
  end

  describe '.authors' do
    it 'groups the authors in the correct order' do
      # Authors should appear in this order:
      # MARC fields: 100, 700, 110, 710
      expect(Sirsi::LibraryRecord.authors(attrs)).to eq [author_100, author_700, author_110, author_710].flatten
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

