require 'rails_helper'

RSpec.describe RangeType do
  describe '.valid_criteria?(criteria)' do
    it 'returns true if there are two criteria, both numeric, with the second larger' do
      expect(RangeType.valid_criteria?([1, 2])).to eq(true)
    end

    it 'returns false if the criteria has more than two members' do
      expect(RangeType.valid_criteria?([1,2,3])).to eq(false)
    end

    it 'returns false if any of the criteria are not numeric' do
      expect(RangeType.valid_criteria?([1,'2'])).to eq(false)
    end

    it 'returns false if the second criteria is not larger than the first' do
      expect(RangeType.valid_criteria?([2, 1])).to eq(false)
    end
  end

  describe '.valid_attribute?(attribute, criteria)' do
    it 'returns true if the attribute is a number between the two criteria, inclusive' do
      expect(RangeType.valid_attribute?(3, [1,4])).to eq(true)
    end

    it 'returns false if the attribute is not numeric' do
      expect(RangeType.valid_attribute?('4', [1,5])).to eq(false)
    end

    it 'returns false if the attribute is outside of the range' do
      expect(RangeType.valid_attribute?(10, [1, 9])).to eq(false)
    end
  end
end
