module ShowHelper

  def show_attribute(document, field, label)
    unless document[field].blank?
      label = content_tag(:dt, label + ':')
      value = Array(document[field]).join(' ').html_safe
      value = content_tag(:dd, value)
      content_tag(:span, label + value)
    end
  end

end
