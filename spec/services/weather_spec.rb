require 'rails_helper'

describe WeatherService do
  describe 'class methods' do
    before :each do
      forcast_response = File.read('spec/fixtures/denver_forcast.json')
      stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?lat=39.738453&lon=-104.984853&appid=#{ENV['OW_API_KEY']}")
        .to_return(status: 200, body: forcast_response)
    end
    it '.get_weather' do
      response = WeatherService.get_weather(39.738453, -104.984853)
      expect(response).to be_a Hash

      expect(response.count).to eq(8)

      expect(response[:lat]).to eq(39.7385)
      expect(response[:lat]).to be_a Float

      expect(response[:lon]).to eq(-104.9849)
      expect(response[:lon]).to be_a Float

      expect(response[:timezone]).to eq('America/Denver')
      expect(response[:timezone]).to be_a String

      expect(response[:current]).to be_a Hash
      expect(response[:current]).to have_key(:dt)
      expect(response[:current]).to have_key(:sunrise)
      expect(response[:current]).to have_key(:sunset)
      expect(response[:current]).to have_key(:temp)
      expect(response[:current]).to have_key(:feels_like)
      expect(response[:current]).to have_key(:humidity)
      expect(response[:current]).to have_key(:uvi)
      expect(response[:current]).to have_key(:visibility)
      expect(response[:current]).to have_key(:weather)
      expect(response[:current][:weather][0]).to have_key(:icon)

      expect(response[:daily]).to be_a Array
      expect(response[:daily][0]).to have_key(:dt)
      expect(response[:daily][0]).to have_key(:sunrise)
      expect(response[:daily][0]).to have_key(:sunset)
      expect(response[:daily][0]).to have_key(:temp)
      expect(response[:daily][0][:temp]).to have_key(:max)
      expect(response[:daily][0][:temp]).to have_key(:min)
      expect(response[:daily][0]).to have_key(:weather)
      expect(response[:daily][0][:weather][0]).to have_key(:icon)

      expect(response[:hourly]).to be_a Array
      expect(response[:hourly][0]).to have_key(:dt)
      expect(response[:hourly][0]).to have_key(:temp)
      expect(response[:hourly][0]).to have_key(:wind_speed)
      expect(response[:hourly][0]).to have_key(:wind_deg)
      expect(response[:hourly][0]).to have_key(:weather)
      expect(response[:hourly][0][:weather][0]).to have_key(:icon)
    end
  end
end
