module HullHistoryCentreHelper

  def title_by_id(value)
    query = 'id:"' + value + '"'
    result = Blacklight.solr.select(params: { q: query })
    doc = result['response']['docs'].first
    name = doc.blank? ? value : Array(doc['title_tesim']).first
  rescue
    value
  end

end