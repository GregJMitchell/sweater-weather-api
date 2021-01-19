require 'rails_helper'

describe 'Creating a road trip' do
  describe "POST '/api/v1/road_trip'" do
    before :each do
      json_response = File.read('spec/fixtures/denver_to_pueblo.json')
      stub_request(:get, "http://open.mapquestapi.com/directions/v2/route?from=Denver,Co&key=#{ENV['MAPQUEST_API_KEY']}&to=Pueblo,Co")
        .to_return(status: 200, body: json_response)
      forcast_response = File.read('spec/fixtures/pueblo_forcast.json')
      stub_request(:get, 'https://api.openweathermap.org/data/2.5/onecall?appid=37b66c6ee992a7188c0682f0fe3cbffa&lat=38.254448&lon=-104.609138')
        .to_return(status: 200, body: forcast_response)
    end
    it 'Can create a road trip' do
      user = create(:user, api_key: 'jgn983hy48thw9begh98h4539h4')

      user_params = {
        origin: 'Denver,Co',
        destination: 'Pueblo,Co',
        api_key: user.api_key
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v1/road_trip', headers: headers, params: JSON.generate(user_params)
      
      expect(response.status).to eq(200)
      
      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:data][:type]).to eq('roadtrip')
      expect(json[:data][:id]).to eq(nil)
      expect(json[:data]).to have_key(:attributes)
      expect(json[:data][:attributes]).to have_key(:start_city)
      expect(json[:data][:attributes]).to have_key(:end_city)
      expect(json[:data][:attributes]).to have_key(:travel_time)
      expect(json[:data][:attributes]).to have_key(:weather_at_eta)
      expect(json[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
      expect(json[:data][:attributes][:weather_at_eta]).to have_key(:conditions)
    end

    it "User's api key is incorrect" do
      user = create(:user, api_key: 'jgn983hy48thw9begh98h4539h4')

      user_params = {
        origin: 'Denver,Co',
        destination: 'Pueblo,Co',
        api_key: '1234567kajlskdjbvlku'
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v1/road_trip', headers: headers, params: JSON.generate(user_params)

      json = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(401)
      expect(json[:message]).to eq('unsuccessful')
      expect(json[:error]).to eq('Api Key is incorrect')
    end

    it "starting city does not exist" do
      json_response = File.read('spec/fixtures/empty_starting_city.json')
      stub_request(:get, "http://open.mapquestapi.com/directions/v2/route?from=&key=#{ENV['MAPQUEST_API_KEY']}&to=Pueblo,Co")
        .to_return(status: 200, body: json_response)
      forcast_response = File.read('spec/fixtures/pueblo_forcast.json')
      stub_request(:get, 'https://api.openweathermap.org/data/2.5/onecall?appid=37b66c6ee992a7188c0682f0fe3cbffa&lat=38.254448&lon=-104.609138')
        .to_return(status: 200, body: forcast_response)
      user = create(:user, api_key: 'jgn983hy48thw9begh98h4539h4')

      user_params = {
        origin: '',
        destination: 'Pueblo,Co',
        api_key: user.api_key
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v1/road_trip', headers: headers, params: JSON.generate(user_params)

      expect(response.status).to eq(400)

      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:message]).to eq('unsuccessful')
      expect(json[:error]).to eq('At least two locations must be provided.')
    end
  end
end
