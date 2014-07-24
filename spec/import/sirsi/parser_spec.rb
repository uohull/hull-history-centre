require 'spec_helper'
require_relative '../../../lib/import/sirsi'

describe Sirsi::Parser do
  let(:fixtures_path) { File.expand_path(File.join('spec', 'fixtures', 'sample_sirsi_files')) }
  let(:single_item) { File.join(fixtures_path, 'single_sirsi_record.xml') }

  describe 'attrs_for_record' do
    let(:attrs) {
      xml = Nokogiri::XML(File.read(single_item)).xpath("//#{Sirsi::LibraryRecord.root_xpath}")
      Sirsi::Parser.attrs_for_record(xml, Sirsi::LibraryRecord)
    }

    it 'finds the attributes for that record' do
      expect(attrs[:id]).to eq '1667917'
      expect(attrs[:title]).to match(/Abrâegâe des preuves/)
    end
  end
end

