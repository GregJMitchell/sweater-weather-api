require 'rails_helper'

describe 'User login' do
  describe 'POST /api/v1/sessions' do
    it 'Logs a user in and sends email and api key' do
      user = create(:user, email: 'whatever@example.com')

      user_params = {
        email: 'whatever@example.com',
        password: 'password'
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v1/sessions', headers: headers, params: JSON.generate(user_params)

      expect(response.status).to eq(200)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:data][:type]).to eq('users')
      expect(json[:data][:id]).to eq(user.id.to_s)
      expect(json[:data]).to have_key(:attributes)
      expect(json[:data][:attributes]).to have_key(:email)
      expect(json[:data][:attributes][:email]).to eq(user.email)

      expect(json[:data][:attributes][:api_key]).to eq(user.api_key)
    end

    it 'Incorrect email' do
      user = create(:user, email: 'whatever@example.com')

      user_params = {
        email: 'wrong@example.com',
        password: 'password'
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v1/sessions', headers: headers, params: JSON.generate(user_params)

      expect(response.status).to eq(401)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:message]).to eq('unsuccessful')
      expect(json[:error]).to eq('Email/Password is incorrect')
    end
    it 'Incorrect Password' do
      user = create(:user, email: 'whatever@example.com')

      user_params = {
        email: 'whatever@example.com',
        password: '1234'
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v1/sessions', headers: headers, params: JSON.generate(user_params)

      expect(response.status).to eq(401)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:message]).to eq('unsuccessful')
      expect(json[:error]).to eq('Email/Password is incorrect')
    end
  end
end
