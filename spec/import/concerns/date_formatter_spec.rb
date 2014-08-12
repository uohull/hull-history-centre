require 'spec_helper'
require_relative '../../../lib/import/concerns/date_formatter'

class DateTester
  extend DateFormatter
end

describe DateFormatter do

  describe '.integer_dates' do
    it 'returns nil for unknown dates' do
      expect(DateTester.integer_dates('0')).to eq nil
      expect(DateTester.integer_dates('n.d.')).to eq nil
      expect(DateTester.integer_dates('N.D.')).to eq nil
      expect(DateTester.integer_dates('unknown')).to eq nil
    end

    it 'works for arrays too' do
      expect(DateTester.integer_dates(['0', '1986'])).to eq 1986
    end
  end

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

    it 'returns nil if it is an unknown date' do
      dates = DateTester.expand_dates('0000-0000')
      expect(dates).to eq nil
    end
  end

end
