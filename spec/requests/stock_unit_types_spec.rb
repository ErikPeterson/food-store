require 'rails_helper'
require './spec/support/jwt_helper'
require './spec/support/request_helper'

RSpec.configure do |config|
  config.include JWTHelper
  config.include RequestHelper

  def expected_json(sut)
    {
      stock_unit_type: {
        id: sut.id,
        name: sut.name,
        schema: sut.schema.as_json
      }
    }
  end
end

RSpec.describe 'POST /api/v1/stock_unit_types', type: :request do
  it 'responds with a 401 if no user is authenticated' do
    post('/api/v1/stock_unit_types', {})

    expect(response.status).to eq(401)
  end

  it 'responds with a 400 if the resource is invalid' do
    user = create(:user)
    params = {
      stock_unit_type: {
        name: 'Coffee',
        schema: [['score', 'RangeType', 10, 1]]
      }
    }

    post_with_authorization(user, '/api/v1/stock_unit_types', params: params.to_json)

    expect(response.status).to eq(400)
  end

  it 'responds with a 200 and the resource after successful creation' do
    user = create(:user)
    params = {
      stock_unit_type: {
        name: 'Coffee',
        schema: [['score', 'RangeType', 1, 10]]
      }
    }

    post_with_authorization(user, '/api/v1/stock_unit_types', params: params.to_json)
    expect(response.status).to eq(200)
    expect(response_json).to match(expected_json(StockUnitType.last))
  end
end

RSpec.describe 'GET /api/v1/stock_unit_types/:id', type: :request do
  it 'responds with a 401 if no user is authenticated' do
    get '/api/v1/stock_unit_types/1'
    expect(response.status).to eq(401)
  end

  it 'responds with the resource if the user is authenticated' do
    user = create(:user)
    sut = create(:stock_unit_type)

    get_with_authorization(user, "/api/v1/stock_unit_types/#{sut.id}")

    expect(response_json).to match(expected_json(sut))
  end

  it 'responds with a 404 if the resource does not exist' do
    user = create(:user)

    get_with_authorization(user, "/api/v1/stock_unit_types/1")

    expect(response.status).to eq(404)
  end
end
