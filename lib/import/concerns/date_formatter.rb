module DateFormatter

  def expand_dates(date_string)
    date_range = Range.new(*date_string.split('-').map(&:to_i))
    Array(date_range)
  rescue
    nil
  end

end
