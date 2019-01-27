require 'rails_helper'
require './spec/support/jwt_helper'
require './spec/support/request_helper'

RSpec.configure do |config|
  config.include JWTHelper
  config.include RequestHelper

  def expected_json(stock_unit)
    {
      stock_unit: {
        id: stock_unit.id,
        owner_id: stock_unit.owner_id,
        stock_unit_type_name: stock_unit.stock_unit_type_name,
        expiration_date: stock_unit.expiration_date.as_json,
        created_at: stock_unit.created_at.as_json,
        unit_attributes: stock_unit.unit_attributes.with_indifferent_access,
        description: stock_unit.description,
        schema: stock_unit.schema.as_json
      }
    }
  end
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
      stock_unit: {
        stock_unit_type_name: 'coffee',
        description: 'Ethiopian Highland Coffee',
        mass_in_grams: 1000,
        expiration_date: '2019-04-15',
        unit_attributes: {
          'cupping score' => 95,
          variety: 'Arabica'
        }
      }
    }

    user = create(:user)

    post_with_authorization(user, '/api/v1/stock_units', params: body.to_json)

    expect(response.status).to eq(200)
    expect(response_json).to match(expected_json(StockUnit.last))
  end
end

RSpec.describe 'GET /api/v1/stock_units/:id', type: :request do
  it 'returns a 401 if no user is authenticated' do
    get('/api/v1/stock_units/1')
    expect(response.status).to eq(401)
  end

  it 'returns a 403 if the authenticated user is not the owner of the stock unit' do
    owner = create(:user)
    stock_unit = create(:stock_unit, owner: owner)
    requester = create(:user)

    get_with_authorization(requester, "/api/v1/stock_units/#{stock_unit.id}")

    expect(response.status).to eq(403)
  end

  it 'responds with the resource if the owner is authenticated' do
    owner = create(:user)
    stock_unit = create(:stock_unit, owner: owner)

    get_with_authorization(owner, "/api/v1/stock_units/#{stock_unit.id}")

    expect(response.status).to eq(200)
    expect(response_json).to match(expected_json(stock_unit))
  end
end

RSpec.describe 'POST /api/v1/stock_units/:id', type: :request do
  it 'returns a 401 if no user is authenticated' do
    post('/api/v1/stock_units/1')
    expect(response.status).to eq(401)
  end

  it 'returns a 403 if the authenticated user is not the owner of the stock unit' do
    owner = create(:user)
    stock_unit = create(:stock_unit, owner: owner)
    requester = create(:user)

    post_with_authorization(requester, "/api/v1/stock_units/#{stock_unit.id}")

    expect(response.status).to eq(403)
  end

  it 'responds with a 400 if the update is invalid' do
    coffee = create(:stock_unit_type,
      name: 'coffee',
      schema: [
        ['cupping score', 'RangeType', 1, 100],
        ['variety', 'ListType', 'Arabica', 'Robusto', 'Gheisha']
    ])

    user = create(:user)

    stock_unit = create(:stock_unit,
      owner: user,
      stock_unit_type_name: 'coffee',
      description: 'Ethiopian Highland Coffee',
      mass_in_grams: 1000,
      expiration_date: '2019-04-15',
      unit_attributes: {
        'cupping score' => 95,
        variety: 'Arabica'
      }
    )

    params = {
      stock_unit: {
        description: 'Some Other Coffee',
        unit_attributes: {
          'cupping score' => 405
        }
      }
    }

    post_with_authorization(user, "/api/v1/stock_units/#{stock_unit.id}", params: params.to_json)

    expect(response.status).to eq(400)
  end

  it 'responds with the updated resource if the owner is authenticated' do
    coffee = create(:stock_unit_type,
      name: 'coffee',
      schema: [
        ['cupping score', 'RangeType', 1, 100],
        ['variety', 'ListType', 'Arabica', 'Robusto', 'Gheisha']
    ])

    user = create(:user)

    stock_unit = create(:stock_unit,
      owner: user,
      stock_unit_type_name: 'coffee',
      description: 'Ethiopian Highland Coffee',
      mass_in_grams: 1000,
      expiration_date: '2019-04-15',
      unit_attributes: {
        'cupping score' => 95,
        variety: 'Arabica'
      }
    )

    params = {
      stock_unit: {
        description: 'Some Other Coffee',
        unit_attributes: {
          'cupping score' => 82,
          variety: 'Robusto'
        }
      }
    }

    post_with_authorization(user, "/api/v1/stock_units/#{stock_unit.id}", params: params.to_json)

    expect(response.status).to eq(200)
    expect(response_json).to match(expected_json(stock_unit.reload))
  end
end

RSpec.describe 'DELETE /api/v1/stock_units/#{stock_unit.id}', type: :request do
  it 'returns a 401 if no user is authenticated' do
    delete('/api/v1/stock_units/1', params: '{}')
    expect(response.status).to eq(401)
  end

  it 'returns a 403 if the authenticated user is not the owner of the stock unit' do
    owner = create(:user)
    stock_unit = create(:stock_unit, owner: owner)
    requester = create(:user)

    delete_with_authorization(requester, "/api/v1/stock_units/#{stock_unit.id}")

    expect(response.status).to eq(403)
  end

  it 'returns a 204 if the resource was successfully deleted' do
    owner = create(:user)
    stock_unit = create(:stock_unit, owner: owner)
    requester = create(:user)

    delete_with_authorization(owner, "/api/v1/stock_units/#{stock_unit.id}")

    expect(response.status).to eq(204)
  end
end
