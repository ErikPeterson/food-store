class StockUnit < ApplicationRecord
  belongs_to :owner, class_name: 'User'
  belongs_to :stock_unit_type
end
