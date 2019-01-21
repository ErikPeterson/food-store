require 'rails_helper'

RSpec.describe StockUnitTypeSchemaValidator do

  let(:fake_validation_type){
    fvt = double("FakeValidationType")
    allow(fvt).to receive(:valid_criteria?).with(['valid']).and_return(true)
    allow(fvt).to receive(:valid_criteria?).with(['invalid']).and_return(false)
    fvt
  }

  describe '.validate!(schema)' do
    it 'raises an error if any of the types are not valid' do
      schema = [['Name', 'FakeValidationType', 'invalid']]
      expect{ StockUnitTypeSchemaValidator.validate!(schema) }.to raise_error(
        RuntimeError,
        "FakeValidationType is not a valid validator type"
      )
    end

    it 'raises an error if any of the criteria are not valid for the validator type' do
      allow(StockUnitTypeSchemaValidator).to receive(:validators)
        .with('FakeValidationType').and_return(fake_validation_type)

      schema = [['Name', 'FakeValidationType', 'invalid']]

      expect{ StockUnitTypeSchemaValidator.validate!(schema) }.to raise_error(
        RuntimeError,
        "[\"invalid\"] are not valid criteria for the FakeValidationType type"
      )
    end

    it 'returns true if the criteria are valid for the type' do
      allow(StockUnitTypeSchemaValidator).to receive(:validators)
        .with('FakeValidationType').and_return(fake_validation_type)

      schema = [['Name', 'FakeValidationType', 'valid']]

      expect(StockUnitTypeSchemaValidator.validate!(schema)).to eq(true)
    end
  end
end
