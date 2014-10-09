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

  # Returns the Resource type/Format from the Solr document
  def resource_type_from_document(document)
    resource_type = ""
    resource_type = document["format_ssi"] unless document["format_ssi"].nil?
    resource_type = resource_type.is_a?(Array) ? resource_type.first : resource_type
  end

  def display_resource_thumbnail(document)
    content_tag(:img, nil, class: "img-responsive thumbnail-image" , src: thumbnail_src_from_document(document) )
  end

  def thumbnail_src_from_document(document)
    resource_type = resource_type_from_document(document)

    thumbnail_src = case resource_type
    when "Book"
      asset_path "icon-flat-book.png"
    when "CD/DVD"
      asset_path "icon-flat-dvd.png"
    when "Map"
      asset_path "icon-flat-map.png"
    when "Microfilm"
      asset_path "icon-flat-microfilm.png"
    # no icons created yet
    #when "Newspaper"
      #asset_path "icon-flat-file"
    #when "Pamphlet"
      #asset_path "icon-flat-file"
    #when "Cassette"
      #asset_path "icon-flat-file"
    when "Video"
      asset_path "icon-flat-video.png"
    else
       asset_path "icon-flat-file.png"
    end

  end

end