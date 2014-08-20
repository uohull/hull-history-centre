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
    keys = [['collection_title_ss', 'collection_id_ssi'],
            ['sub_collection_title_ss', 'sub_collection_id_ss'],
            ['series_title_ss', 'series_id_ss'],
            ['sub_series_title_ss', 'sub_series_id_ss'],
            ['item_title_ss', 'item_id_ssi']
    ]

    # If we have the ID for a solr document, the breadcrumb
    # should be a link to that document.  Else, just print the
    # breadcrumb's title as a String.
    crumbs = keys.map do |(title_key, id_key)|
      breadcrumb_title = document[title_key]
      if document[id_key]
        link_to breadcrumb_title, catalogue_path(document[id_key])
      else
        breadcrumb_title
      end
    end

    current_crumb = document['title_tesim'].first
    crumbs = crumbs + [current_crumb]
    crumbs = crumbs.compact.join(' &gt; ').html_safe
  end

  def author_label(solr_doc)
    author_count = Array(solr_doc['author_tesim']).count
    author_count > 1 ? 'Authors: ' : 'Author: '
  end

end
