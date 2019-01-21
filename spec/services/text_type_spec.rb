require 'rails_helper'

RSpec.describe TextType do
  describe '.valid_criteria?(criteria)' do
    it 'returns true if criteria is empty' do
      expect(TextType.valid_criteria?([])).to eq(true)
    end

    it 'returns true if criteria has a single member that is a positive integer' do
      expect(TextType.valid_criteria?([1])).to eq(true)
    end

    it 'returns false if criteria is negative or zero' do
      expect(TextType.valid_criteria?([-1])).to eq(false)
      expect(TextType.valid_criteria?([0])).to eq(false)
    end

    it 'returns false if there is more than one member of the criteria array' do
      expect(TextType.valid_criteria?([1,2])).to eq(false)
    end
  end

  describe '.valid_attribute?(attribute, criteria)' do
    it 'returns true if the attribute is a string, and criteria is empty' do
      expect(TextType.valid_attribute?('Hello',[])).to eq(true)
    end

    it 'returns true if the attribute is a string of length <= criteria' do
      expect(TextType.valid_attribute?('Hello', [5])).to eq(true)
    end

    it 'returns false if the attribute is not a string' do
      expect(TextType.valid_attribute?(1, [])).to eq(false)
    end

    it 'returns false if the attribute is a string of length > criteria' do
      expect(TextType.valid_attribute?('Hello', [3])).to eq(false)
    end
  end
end
