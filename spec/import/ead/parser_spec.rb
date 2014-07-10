require 'spec_helper'
require_relative '../../../lib/import/ead'

describe Ead::Parser do
  let(:fixtures_path) { File.expand_path(File.join('spec', 'fixtures', 'sample_ead_files')) }
  let(:ead_file) { File.join(fixtures_path, 'U_DDH.xml') }

  describe 'attrs_for_record' do
    context 'for a single Item' do
      it 'finds the attributes for that item' do
        xml = Nokogiri::XML(item_14).xpath("//#{Ead::Item.root_xpath}")
        attrs = Ead::Parser.attrs_for_record(xml, Ead::Item)
        expect(attrs[:id]).to eq 'U DDH/14'
        expect(attrs[:title]).to eq 'Photocopy. Revolutionary Communist Party'
      end
    end

    context 'for a single Collection' do
      it 'finds the attributes for that collection' do
        xml = Nokogiri::XML(File.read(ead_file))
        collection_node = xml.xpath("#{Ead::Collection.root_xpath}").first
        attrs = Ead::Parser.attrs_for_record(collection_node, Ead::Collection)
        expect(attrs[:id]).to eq 'U DDH'
        expect(attrs[:title]).to eq 'Papers of Denzil Dean Harber'
      end
    end
  end

  describe '.parse_records' do
    context 'for Item records' do
      it 'finds the attributes for all items' do
        xml = Nokogiri::XML(two_items).xpath('*')
        items = Ead::Parser.parse_records(xml, Ead::Item)
        expect(items.count).to eq 2
        expect(items.last[:id]).to eq 'U DDH/14'
        expect(items.last[:title]).to eq 'Photocopy. Revolutionary Communist Party'
      end
    end

    context 'for Collection records' do
      it 'finds the attributes for the collection(s)' do
        xml = Nokogiri::XML(File.read(ead_file))
        collections = Ead::Parser.parse_records(xml, Ead::Collection)
        expect(collections.count).to eq 1
        expect(collections.first[:id]).to eq 'U DDH'
        expect(collections.first[:title]).to eq 'Papers of Denzil Dean Harber'
      end
    end
  end

  describe '.parse' do
    it 'returns a hash of object attributes' do
      objects = Ead::Parser.parse(ead_file)
      expect(objects[:items].count).to eq 14
      expect(objects[:collections].count).to eq 1
    end
  end

end


def item_13
  <<-END13
    <c level="item">
      <did>
        <unittitle encodinganalog="3.1.2">Photocopy. Workers&apos; International League </unittitle>
        <unitdate datechar="creation" encodinganalog="3.1.3.2" label="Creation Dates" type="inclusive" normal="1938-1942">1938-1942</unitdate>
        <physdesc encodinganalog="3.4.4" label="Extent">
          <extent>1 file</extent>
        </physdesc>
        <repository encodinganalog="3.1.2">Hull University Archives</repository>
        <unitid label="Former Reference">U DDH/13</unitid>
        <unitid encodinganalog="3.1.1" label="Reference" countrycode="GB" repositorycode="050">U DDH/13</unitid>
      </did>
      <scopecontent encodinganalog="3.3.1"><p>Includes statements, constitution and correspondence</p></scopecontent>
    </c>
  END13
end

def item_14
  <<-END14
    <c level="item">
      <did>
        <unittitle encodinganalog="3.1.2">Photocopy. Revolutionary Communist Party </unittitle>
        <unitdate datechar="creation" encodinganalog="3.1.3.2" label="Creation Dates" type="inclusive" normal="1944-1946">1944-1946</unitdate>
        <physdesc encodinganalog="3.4.4" label="Extent">
          <extent>1 file</extent>
        </physdesc>
        <repository encodinganalog="3.1.2">Hull University Archives</repository>
        <unitid label="Former Reference">U DDH/14 former</unitid>
        <unitid encodinganalog="3.1.1" label="Reference" countrycode="GB" repositorycode="050">U DDH/14</unitid>
      </did>
      <scopecontent encodinganalog="3.3.1"><p>Includes internal documents, bulletins and correspondence</p></scopecontent>
    </c>
  END14
end

def two_items
  "<ead>" + item_13 + item_14 + "</ead>"
end

