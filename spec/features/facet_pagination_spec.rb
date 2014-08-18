require 'rails_helper'
require 'import/ead'

feature 'Facet pagination:' do
  let(:fixtures_path) { File.expand_path(File.join('spec', 'fixtures', 'sample_ead_files')) }
  let(:dar_file) { File.join(fixtures_path, 'U_DAR_pruned.xml') }

  before do
    Blacklight.solr.delete_by_query("*:*", params: { commit: true })
    allow(Ead::Parser).to receive(:verbose) { false }
    allow(Ead::Importer).to receive(:verbose) { false }
    Ead::Importer.import(dar_file)
  end

  scenario 'Selecting a facet limit' do
    visit root_path

    within('#facet-dates_isim') do
      click_link 'more »'
    end

    expect(page).to have_selector('.facet_extended_list ul.facet-values')

    within('.top') do
      click_link 'Numerical Sort'
      click_link 'Next »'
    end

    click_link '1971'

    # Should have 4 search results
    expect(page).to have_selector('#documents .document', count: 4)

    # The search constraints should include the date 1971
    expect(page).to have_selector('.filterName', count: 1, text: 'Date')
    expect(page).to have_selector('.filterValue', count: 1, text: '1971')
  end

end

