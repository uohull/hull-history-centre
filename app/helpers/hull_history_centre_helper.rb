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

  # Returns the Resource type/Genre from the Solr document
  def resource_type_from_document(document)
    resource_type = ""
    resource_type = document["genre_ssm"] unless document["genre_ssm"].nil?
    resource_type = resource_type.is_a?(Array) ? resource_type.first : resource_type
  end

  def display_resource_thumbnail(document)
    #/assets/dvd-thumb-lg.png
    #content_tag(:img, nil, url: thumbnail_src_from_document(document) )
    # format ssi
    #content_tag(:img, nil, class: "img-responsive" , src: thumbnail_src_from_document(document) )
    content_tag(:img, nil, class: "img-responsive" , src: "/assets/dvd-thumb-lg.png" )
  end

  def thumbnail_src_from_document(document)
    resource_src = resource_type_from_document(document)

    thumbnail_src = case resource_type
    when "Book"
      "/assets/dvd-thumb-lg.png"
    when "Meeting papers or minutes"
      "calendar-thumb"
    when "Dataset"
      "dataset-thumb"
    when "Presentation"
      "presentation-thumb"
    when "Policy or procedure", "Regulation"
      "policy-thumb"
    when "Photograph", "Artwork"
      "image-thumb"
    when "Thesis or dissertation"
      "thesis-thumb"
    when "Handbook"
      "handbook-thumb"
    when "Book"
      "domesday-thumb"
    else
      "generic-thumb"
    end

  end

end