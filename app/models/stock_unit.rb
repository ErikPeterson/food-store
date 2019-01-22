class StockUnit < ApplicationRecord
  belongs_to :owner, class_name: 'User'
  belongs_to :stock_unit_type
  validate :attributes_meet_schema

  def schema
    @schema ||= stock_unit_type.schema
  end

  def attributes_meet_schema
    StockUnitAttributeValidator.validate!(schema, unit_attributes)
  rescue StandardError => e
    self.errors.add(:unit_attributes, e.message)
  end
end
