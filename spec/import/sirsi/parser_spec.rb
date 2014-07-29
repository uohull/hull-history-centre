require 'spec_helper'
require_relative '../../../lib/import/sirsi'

describe Sirsi::Parser do
  let(:fixtures_path) { File.expand_path(File.join('spec', 'fixtures', 'sample_sirsi_files')) }
  let(:single_item) { File.join(fixtures_path, 'single_sirsi_record.xml') }
  let(:sirsi_records) { File.join(fixtures_path, 'full_record_sample.xml') }

  before do
    allow(Sirsi::Parser).to receive(:verbose) { false }
  end

  describe '.attrs_for_record' do
    let(:attrs) {
      xml = Nokogiri::XML(File.read(single_item)).xpath("//#{Sirsi::LibraryRecord.root_xpath}")
      Sirsi::Parser.attrs_for_record(xml, Sirsi::LibraryRecord)
    }

    it 'finds the attributes for that record' do
      expect(attrs[:id]).to eq '1667917'
      expect(attrs[:title]).to match(/Abrâegâe des preuves/)
      expect(attrs[:format]).to eq 'ANFHBK'
      expect(attrs[:subject]).to eq ['Slave-trade--Great Britain--Early works to 1800.', 'Antislavery movements--Great Britain.']
    end
  end

  describe '.parse' do
    it 'returns a hash with attributes for all the library records' do
      records = Sirsi::Parser.parse(sirsi_records)
      expect(records[:library_records].count).to eq 3
    end
  end
end

