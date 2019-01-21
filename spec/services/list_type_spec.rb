require 'rails_helper'

RSpec.describe 'ListType' do
  describe '.valid_criteria?(criteria)' do
    it 'returns true if criteria is a one dimensional array of scalar types' do
      expect(ListType.valid_criteria?([1, '2', 3.0])).to eq(true)
    end

    it 'returns false if criteria is not an array' do
      expect(ListType.valid_criteria?(1)).to eq(false)
    end

    it 'returns false if any array members are not scalar' do
      expect(ListType.valid_criteria?([1, 2, []])).to eq(false)
    end
  end

  describe '.valid_attribute?(attribute, criteria)' do
    it 'returns true if the attribute value is a member of criteria' do
      expect(ListType.valid_attribute?('1', [0, '1', 'seven'])).to eq(true)
    end

    it 'returns false if the attribute value is not a member of criteria' do
      expect(ListType.valid_attribute?('ten', [10])).to eq(false)
    end
  end
end
