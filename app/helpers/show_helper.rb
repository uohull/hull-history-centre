module ShowHelper

  def show_attribute(document, field, label)
    unless document[field].blank?
      label = content_tag(:dt, label + ':')
      value = Array(document[field]).join(' ').html_safe
      value = content_tag(:dd, value)
      content_tag(:span, label + value)
    end
  end

  def breadcrumbs(document)
    keys = [['collection_title_ss', 'collection_id_ss'],
            ['series_title_ss', 'series_id_ss']
    ]

    # If we have the ID for a solr document, the breadcrumb
    # should be a link to that document.  Else, just print the
    # breadcrumb's title as a String.
    crumbs = keys.map do |(title_key, id_key)|
      breadcrumb_title = document[title_key]
      if document[id_key]
        link_to breadcrumb_title, catalog_path(document[id_key])
      else
        breadcrumb_title
      end
    end

    current_crumb = document['title_tesim'].first
    crumbs = crumbs + [current_crumb]
    crumbs = crumbs.compact.join(' &gt; ').html_safe
  end

end
