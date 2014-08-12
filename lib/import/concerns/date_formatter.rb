module DateFormatter

  UNKNOWN_DATE = 'unknown'

  def unknown_dates
    ['0', 'n.d.', 'no date', 'not dated', 'unknown']
  end

  def expand_dates(date_string)
    date_range = Range.new(*date_string.split('-'))
    integer_dates(date_range)
  rescue
    nil
  end

  def standardized_dates(date_string)
    dates = Array(date_string).map do |date|
      if unknown_dates.include?(date.downcase)
        UNKNOWN_DATE
      elsif date.to_i == 0
        UNKNOWN_DATE
      else
        date
      end
    end
    dates = dates.first if dates.length == 1
    dates
  end

  def integer_dates(date_string)
    dates = standardized_dates(date_string)

    dates = Array(dates).map do |date|
      date == UNKNOWN_DATE ? nil : date.to_i
    end.compact

    if dates.empty?
      nil
    elsif dates.length == 1
      dates.first
    else
      dates
    end
  end

end
