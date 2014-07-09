class Item

  ATTRIBUTES = [:id, :title]
  ATTRIBUTES.each {|f| attr_accessor f }

  def initialize(attributes = {})
    attributes.each do |k, v|
      setter_method = k.to_s + "="
      send(setter_method, v)
    end
  end

  def to_solr(doc = {})
    doc.tap do |fields|
      fields['id'] = id
      fields['title_tesim'] = title
    end
  end

  def save
  end
end
