json.page page
json.per_page per_page
json.sort sort
json.stock_units stock_units do |stock_unit|
  json.partial! 'stock_units/stock_unit', stock_unit: stock_unit
end