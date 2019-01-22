FactoryBot.define do
  factory :stock_unit do
    owner factory: :user
    stock_unit_type
    description { "MyText" }
    mass_in_grams { 1 }
    expiration_date { "2019-01-21" }
  end
end
