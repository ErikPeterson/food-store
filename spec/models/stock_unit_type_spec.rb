require 'rails_helper'
require './spec/support/database_cleaner.rb'

RSpec.describe StockUnitType, type: :model do
  context 'name' do
    it 'must be present' do
      expect{ create(:stock_unit_type, name: nil, schema: {} )}.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'must be unique' do
      create(:stock_unit_type, name: 'coffee', schema: {})
      expect{ create(:stock_unit_type, name: 'coffee', schema: {}) }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  context 'schema' do
    # it's an array of arrays
    # each array element is an attribute definition
      # first element is the name
      # second element is the attribute type
      # any additional elements are criteria for validation

    let(:fake_validation_type){
      fvt = double("FakeValidationType")
      allow(fvt).to receive(:valid_criteria?).with(['valid']).and_return(true)
      allow(fvt).to receive(:valid_criteria?).with(['invalid']).and_return(false)
      fvt
    }

    it 'must be valid' do
      allow(StockUnitTypeSchemaValidator).to receive(:validators)
        .with('FakeValidationType').and_return(fake_validation_type)

      valid_schema = [
        ['tasting notes', 'FakeValidationType', 'valid'],
        ['score', 'FakeValidationType', 'valid']
      ]

      invalid_schema = [
        ['catch location', 'FakeValidationType', 'valid'],
        ['USDA grade', 'FakeValidationType', 'invalid']
      ]

      expect{
        create(:stock_unit_type, name: 'coffee', schema: valid_schema)
      }.to_not raise_error

      expect{
        create(:stock_unit_type, name: 'fish', schema: invalid_schema)
      }.to raise_error(
        ActiveRecord::RecordInvalid
      )
    end
  end
end
