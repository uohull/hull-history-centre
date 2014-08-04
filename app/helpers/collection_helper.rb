module CollectionHelper

  def tab_class(this_tab, selected_tab)
    this_tab == selected_tab ? 'current-tab' : ''
  end

  def collection_name(value)
    query = 'id:"' + value + '"'
    result = Blacklight.solr.select(params: { q: query })
    doc = result['response']['docs'].first
    name = doc.blank? ? value : Array(doc['title_tesim']).first
  rescue
    value
  end

end
