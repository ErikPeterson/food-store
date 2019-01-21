require 'rails_helper'

RSpec.describe 'POST /signup', type: :request do
  def json
    JSON.parse(response.body).with_indifferent_access
  end

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
        expect(json[key]).to be_present
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
      expect(json['errors'].first['title']).to eq('Bad Request')
    end
  end
end