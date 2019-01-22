require 'rails_helper'

RSpec.describe StockUnitAttributeValidator do
  describe '.validate!(schema, attributes)' do
    it 'returns true if the attributes are valid for the schema' do
      schema = [
        ['flavor notes', 'TextType', 100],
        ['score', 'RangeType', 0, 10],
        ['blend', 'ListType', 'Ethiopian', 'Ugandan']
      ]

      attributes = {
        'flavor notes' => 'What a tasty coffee',
        'score' => 8,
        'blend' => 'Ethiopian'
      }

      expect(StockUnitAttributeValidator.validate!(schema, attributes)).to eq(true)
    end

    it 'raises an error if the attributes are not valid for the schema' do
      schema = [
        ['flavor notes', 'TextType', 4],
        ['score', 'RangeType', 0, 10],
        ['blend', 'ListType', 'Ethiopian', 'Ugandan']
      ]

      attributes = {
        'flavor notes' => 'What a tasty coffee',
        'score' => 11,
        'blend' => 'Ghanaian'
      }

      expect{
        StockUnitAttributeValidator.validate!(schema, attributes)
      }.to raise_error(
        StandardError,
        /is not a valid value for attribute/
      )
    end

    it 'raises an error if any attribute is not in the schema' do
      schema = [
        ['flavor notes', 'TextType', 100],
        ['score', 'RangeType', 0, 10],
        ['blend', 'ListType', 'Ethiopian', 'Ugandan']
      ]

      attributes = {
        'flavor notes' => 'What a tasty coffee',
        'score' => 8,
        'blend' => 'Ethiopian',
        'hey' => 'now'
      }

      expect{
        StockUnitAttributeValidator.validate!(schema, attributes)
      }.to raise_error(
        StandardError,
        /hey is not a valid attribute for this type/
      )
    end
  end
end
