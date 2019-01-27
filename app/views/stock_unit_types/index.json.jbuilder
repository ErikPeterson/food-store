json.page page
json.per_page per_page
json.sort sort
json.stock_unit_types stock_unit_types do |stock_unit_type|
  json.partial! 'stock_unit_types/stock_unit_type', stock_unit_type: stock_unit_type
end