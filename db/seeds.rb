admin = User.create!({
  email: 'fake@user.com',
  password: '123456'
})

StockUnitType.create!({
  name: 'fish',
  schema: [
    ['catch location', 'TextType'],
    ['variety', 'ListType', 'halibut', 'swordfish', 'pike', 'salmon'],
    ['score', 'RangeType', 1, 100]
  ]
})

StockUnit.create!({
  description: 'Nova Scotia Salmon',
  mass_in_grams: 1000,
  stock_unit_type_name: 'fish',
  owner: admin,
  expiration_date: Time.zone.now + 2.days,
  unit_attributes: {
    'catch location' => 'Nova Scotia',
    'variety' => 'salmon',
    'score' => 50
  }
})
