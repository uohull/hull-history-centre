module IdFormatter

  def format_id(raw_id)
    return unless raw_id
    raw_id.gsub(' ', '-').gsub('/', '-')
  end

end
