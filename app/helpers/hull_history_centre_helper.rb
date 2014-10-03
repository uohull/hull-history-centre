module HullHistoryCentreHelper

  def title_by_id(value)
    query = 'id:"' + value + '"'
    result = Blacklight.solr.select(params: { q: query })
    doc = result['response']['docs'].first
    name = doc.blank? ? value : Array(doc['title_tesim']).first
  rescue
    value
  end

  def render_selected_facet_value(facet_solr_field, item)
    content_tag(:span, :class => "facet-label") do
    content_tag(:span, facet_display_value(facet_solr_field, item), :class => "selected") + render_facet_count(item.hits, :classes => ["selected"])
    # remove link
    #link_to(content_tag(:span, '', :class => "glyphicon glyphicon-remove") + content_tag(:span, '[remove]', :class => 'sr-only'), search_action_path(remove_facet_params(facet_solr_field, item, params)), :class=>"remove")
    #end + render_facet_count(item.hits, :classes => ["selected"])
    end
  end

end