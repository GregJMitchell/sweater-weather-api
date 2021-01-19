require 'rails_helper'

describe 'api/v1/forecast' do
  describe 'GET api/v1/forecast' do
    before :each do
      json_response = File.read('spec/fixtures/denver_mapquest_search.json')
      stub_request(:get, "#{ENV['MAPQUEST_URL']}?key=#{ENV['MAPQUEST_API_KEY']}&inFormat=kvp&outFormat=json&location=denver%2C+co&thumbMaps=false")
        .to_return(status: 200, body: json_response)
      forcast_response = File.read('spec/fixtures/denver_forcast.json')
      stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?lat=39.738453&lon=-104.984853&appid=#{ENV['OW_API_KEY']}")
        .to_return(status: 200, body: forcast_response)
    end

    it 'retrieves the weather for a city' do
      get '/api/v1/forecast?location=denver,co'

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      expect(json[:data][:id]).to be_nil
      expect(json[:data][:type]).to eq('forecast')

      expect(json[:data][:attributes].count).to eq(3)

      expect(json[:data][:attributes]).to have_key(:current_weather)
      expect(json[:data][:attributes]).to have_key(:daily_weather)
      expect(json[:data][:attributes]).to have_key(:hourly_weather)

      current_weather = json[:data][:attributes][:current_weather]
      expect(current_weather.count).to eq(10)

      daily_weather = json[:data][:attributes][:daily_weather]
      expect(daily_weather.count).to eq(5)
      expect(daily_weather[0].count).to eq(7)

      hourly_weather = json[:data][:attributes][:hourly_weather]

      expect(hourly_weather.count).to eq(8)
      expect(hourly_weather[0].count).to eq(6)
    end

    it 'retreives data for cities in other countries' do
      json_response = File.read('spec/fixtures/london_mapquest_search.json')
      stub_request(:get, "#{ENV['MAPQUEST_URL']}?key=#{ENV['MAPQUEST_API_KEY']}&inFormat=kvp&outFormat=json&location=london%2C+uk&thumbMaps=false")
        .to_return(status: 200, body: json_response)
      forcast_response = File.read('spec/fixtures/london_forcast.json')
      stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?lat=51.50015&lon=-0.12624&appid=#{ENV['OW_API_KEY']}")
        .to_return(status: 200, body: forcast_response)

      get '/api/v1/forecast?location=london,uk'

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      expect(json[:data][:id]).to be_nil
      expect(json[:data][:type]).to eq('forecast')
    end

    it 'Search is an empty string' do
      json_response = File.read('spec/fixtures/empty.json')
      stub_request(:get, "#{ENV['MAPQUEST_URL']}?key=#{ENV['MAPQUEST_API_KEY']}&inFormat=kvp&outFormat=json&location=%2C+&thumbMaps=false")
        .to_return(status: 200, body: json_response)
      forcast_response = File.read('spec/fixtures/empty_forcast.json')
      stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?lat=&lon=&appid=#{ENV['OW_API_KEY']}")
        .to_return(status: 200, body: forcast_response)

      get '/api/v1/forecast?location='

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(400)

      expect(json[:message]).to eq('unsuccessful')
      expect(json[:error]).to eq('Nothing to geocode')
      # expect(json[:data][:type]).to eq('forecast')
    end
  end
end
