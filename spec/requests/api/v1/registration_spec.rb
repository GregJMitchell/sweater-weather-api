require 'rails_helper'

describe 'User registration' do
  describe 'POST /api/v1/users' do
    it 'creates a user' do
      user_params = {
        email: 'whatever@example.com',
        password: 'password',
        password_confirmation: 'password'
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v1/users', headers: headers, params: JSON.generate(user_params)

      expect(response.status).to eq(200)

      expect(User.last.email).to eq(user_params[:email])
    end

    it 'serializes user data' do
      user_params = {
        email: 'whatever@example.com',
        password: 'password',
        password_confirmation: 'password'
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v1/users', headers: headers, params: JSON.generate(user_params)

      json = JSON.parse(response.body, symbolize_names: true)

      user = User.last

      expect(json[:data][:type]).to eq('user')
      expect(json[:data][:id]).to eq(user.id.to_s)
      expect(json[:data]).to have_key(:attributes)
      expect(json[:data][:attributes]).to have_key(:email)
      expect(json[:data][:attributes][:email]).to eq(user.email)

      expect(json[:data][:attributes][:api_key]).to eq(user.api_key)
    end

    it 'Non-matching passwords' do
      user_params = {
        email: 'whatever@example.com',
        password: 'password',
        password_confirmation: '1234'
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v1/users', headers: headers, params: JSON.generate(user_params)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(User.find_by(email: user_params[:email])).to eq(nil)

      expect(json[:message]).to eq('unsuccessful')
      expect(json[:error]).to eq('Could not create user')
      expect(response.status).to eq(422)
    end

    it 'User already exists in database' do
      user = create(:user, email: 'whatever@example.com')

      user_params = {
        email: 'whatever@example.com',
        password: 'password',
        password_confirmation: 'password'
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v1/users', headers: headers, params: JSON.generate(user_params)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(409)

      expect(json[:message]).to eq('unsuccessful')
      expect(json[:error]).to eq('User already exists')
    end
  end
end
