require 'rails_helper'
require './spec/support/database_cleaner'
require './spec/support/request_helper'

RSpec.configure{ |config| config.include RequestHelper }

RSpec.describe 'POST /signup', type: :request do
  let(:url) { '/signup' }
  let(:params) do
    {
      user: {
        email: 'user@example.com',
        password: 'password'
      }
    }
  end

  context 'when user is unauthenticated' do
    before { post(url, params: params) }

    it 'returns 200' do
      expect(response.status).to eq 200
    end

    it 'returns a new user' do
      [:id, :email, :created_at, :updated_at].each do |key|
        expect(response_json[key]).to be_present
      end
    end
  end

  context 'when user already exists' do
    before do
      create(:user, email: params[:user][:email])
      post(url, params: params)
    end

    it 'returns bad request status' do
      expect(response.status).to eq 400
    end

    it 'returns validation errors' do
      expect(response_json['errors'].first['title']).to eq('Bad Request')
    end
  end
end
