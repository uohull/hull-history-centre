require 'rails_helper'
require 'import/ead'

describe 'catalog/_show_item.html.erb' do
  # Note: title is displayed in a different partial
  let(:non_displayed_fields) { ['type_ssi', 'title_tesim'] }
  let(:breadcrumb_fields) { [ 'collection_id_ss',
                              'collection_title_ss',
                              'sub_collection_title_ss',
                              'series_title_ss',
                              'sub_series_title_ss' ] }
  let(:item_keys) { Ead::Item.to_solr({}).keys - non_displayed_fields - breadcrumb_fields }

  before do
    render partial: 'catalog/show_item.html.erb',
           locals: { document: SolrDocument.new(fields) }
  end

  describe 'Display an Item:' do
    let(:fields) {
      attrs = item_keys.inject({}) do |attrs, key|
        # Make up a different value for each field
        value = key + ' ' + rand(100).to_s
        attrs = attrs.merge( { key => value })
      end
      attrs = attrs.merge('collection_id_ss' => '123')
    }

    it 'displays all the defined fields on the show page' do
      fields.each do |key, value|
        expect(rendered).to have_content(value)
      end
    end
  end
end
