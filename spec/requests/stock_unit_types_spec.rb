require 'rails_helper'
require './spec/support/jwt_helper'
require './spec/support/request_helper'

def expected_sut_json(sut)
  {
    stock_unit_type: {
      id: sut.id,
      name: sut.name,
      schema: sut.schema.as_json
    }
  }
end

RSpec.configure do |config|
  config.include JWTHelper
  config.include RequestHelper
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
    expect(response_json).to match(expected_sut_json(StockUnitType.last))
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

    expect(response_json).to match(expected_sut_json(sut))
  end

  it 'responds with a 404 if the resource does not exist' do
    user = create(:user)

    get_with_authorization(user, "/api/v1/stock_unit_types/1")

    expect(response.status).to eq(404)
  end
end

RSpec.describe 'GET /api/v1/stock_unit_types', type: :request do
  it 'responds with a 401 if not user is authenticated' do
    get '/api/v1/stock_unit_types'

    expect(response.status).to eq(401)
  end

context 'pagination' do
    def setup_resources(n=10)
      user = create(:user)
      stock_unit_types = create_list(:stock_unit_type, n)
      [user, stock_unit_types]
    end

    context 'sort' do
      it "orders by created_at descending by default" do
        user, stock_units = setup_resources

        get_with_authorization(user, '/api/v1/stock_unit_types')

        expect(
          response_json[:stock_unit_types].collect{ |j| j[:id] }
        ).to eq(
          StockUnitType.all.order(created_at: :desc).limit(10).pluck(:id)
        )
      end

      it "orders by created_at ascending is sort is set to 'asc'" do
        user, stock_unit_types = setup_resources

        get_with_authorization(user, '/api/v1/stock_unit_types?sort=asc')

        expect(
          response_json[:stock_unit_types].collect{ |j| j[:id] }
        ).to eq(
          StockUnitType.all.order(created_at: :asc).limit(10).pluck(:id)
        )
      end

      it "responds with 400 if sort is set to a value other than desc or asc" do
        user = create(:user)

        get_with_authorization(user, '/api/v1/stock_unit_types?sort=butt')

        expect(response.status).to eq(400)
      end
    end

    context 'page' do
      it "defaults to 1" do
        user, stock_unit_types = setup_resources(11)

        get_with_authorization(user, '/api/v1/stock_unit_types?page=1')

        expect(
          response_json[:stock_unit_types].collect{ |j| j[:id] }
        ).to eq(
          StockUnitType.all.order(created_at: :desc).limit(10).pluck(:id)
        )
      end

      it "responds with an empty set if the page is out of bounds" do
        user, stock_unit_types = setup_resources

        get_with_authorization(user, '/api/v1/stock_unit_types?page=2')

        expect(response_json[:stock_unit_types]).to eq([])
      end

      it "responds with the indicated page of resources" do
        user, stock_unit_types = setup_resources(11)

        get_with_authorization(user, '/api/v1/stock_unit_types?sort=desc&page=2')

        expect(
          response_json[:stock_unit_types][0][:id]
        ).to eq(
          StockUnitType.all.order(created_at: :desc).last.id
        )
      end
    end

    context 'per_page' do
      it "defaults to 10" do
        user, stock_unit_types = setup_resources

        get_with_authorization(user, '/api/v1/stock_unit_types')

        expect(response_json[:stock_unit_types].count).to eq(10)
      end

      it "can be set to any positive number" do
        user, stock_unit_types = setup_resources(25)

        get_with_authorization(user, '/api/v1/stock_unit_types?per_page=25')

        expect(response_json[:stock_unit_types].count).to eq(25)
      end
    end
  end
end
