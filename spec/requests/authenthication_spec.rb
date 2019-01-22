require 'rails_helper'
require './spec/support/jwt_helper'
require './spec/support/database_cleaner'

RSpec.configure{ |config| config.include JWTHelper }

RSpec.describe 'POST /login', type: :request do
  let(:user) { create(:user) }
  let(:url) { '/login' }
  let(:params) do
    {
      user: {
        email: user.email,
        password: user.password
      }
    }
  end

  context 'when params are correct' do
    before do
      post(url, params: params)
    end

    it 'returns 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns JTW token in authorization header' do
      expect(response.headers['Authorization']).to be_present
    end

    it 'returns valid JWT token' do
      decoded_token = decode_jwt(response)
      expect(decoded_token['sub']).to be_present
    end
  end

  context 'when login params are incorrect' do
    before { post(url) }

    it 'returns unathorized status' do
      expect(response.status).to eq 401
    end
  end
end
