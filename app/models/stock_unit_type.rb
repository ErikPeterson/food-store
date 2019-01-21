class StockUnitType < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validate :schema_is_valid

  def schema_is_valid
    StockUnitTypeSchemaValidator.validate!(schema)
  rescue StandardError => e
    self.errors.add(:schema, e.message)
  end
end
