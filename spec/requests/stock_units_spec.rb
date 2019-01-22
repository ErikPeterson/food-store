require 'rails_helper'
require './spec/support/jwt_helper'
require './spec/support/request_helper'

RSpec.configure do |config|
  config.include JWTHelper
  config.include RequestHelper
end

RSpec.describe 'POST /api/v1/stock_units', type: :request do

  it 'returns a 401 if no user is authenticated' do
    post('/api/v1/stock_units', params: '{}')
    expect(response.status).to eq(401)
  end

  it 'returns a 400 if the resource was invalid' do
    user = create(:user)
    post_with_authorization(user, '/api/v1/stock_units', params: '{}')
    expect(response.status).to eq(400)
  end

  it 'returns a 200 and the resource if the creation was successful' do
    coffee = create(:stock_unit_type,
      name: 'coffee',
      schema: [
        ['cupping score', 'RangeType', 1, 100],
        ['variety', 'ListType', 'Arabica', 'Robusto', 'Gheisha']
    ])

    body = {
      stock_unit_type_name: 'coffee',
      description: 'Ethiopian Highland Coffee',
      mass_in_grams: 1000,
      expiration_date: '2019-04-15',
      unit_attributes: {
        'cupping score' => 95,
        variety: 'Arabica'
      }
    }

    user = create(:user)

    post_with_authorization(user, '/api/v1/stock_units', params: body.to_json)

    expect(response.status).to eq(200)
    expect(response_json['owner_id']).to eq(user.id)
    expect(response_json['id']).to be_present
    expect(response_json['unit_attributes']).to match({
        'cupping score' => 95,
        'variety' => 'Arabica'
    })
  end
end
