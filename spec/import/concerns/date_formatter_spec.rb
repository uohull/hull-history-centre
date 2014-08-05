require 'spec_helper'
require_relative '../../../lib/import/concerns/date_formatter'

class DateTester
  extend DateFormatter
end

describe DateFormatter do

  describe '.expand_dates' do
    it 'expands a range of dates into an array of integers' do
      dates = DateTester.expand_dates('1998-2002')
      expect(dates).to eq [1998, 1999, 2000, 2001, 2002]
    end

    it 'still works if there is whitespace in the string' do
      dates = DateTester.expand_dates(' 1998 - 2002 ')
      expect(dates).to eq [1998, 1999, 2000, 2001, 2002]
    end

    it 'returns nil if it fails to parse the date string' do
      dates = DateTester.expand_dates('something bad')
      expect(dates).to eq nil
    end
  end

end
