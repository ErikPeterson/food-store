FactoryBot.define do
  factory :stock_unit_type do
    sequence(:name) { |n| "MyString #{n}" }
    schema { {} }
  end
end
