require 'rails_helper'

describe WeatherFacade do
  describe 'class methods' do
    before :each do
      forcast_response = File.read('spec/fixtures/denver_forcast.json')
      stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?lat=39.738453&lon=-104.984853&appid=#{ENV['OW_API_KEY']}")
        .to_return(status: 200, body: forcast_response)
    end
    it '.get_weather' do
      response = WeatherFacade.get_weather(39.738453, -104.984853)
      expect(response).to be_a Forecast

      expect(response.current_weather).to be_a CurrentWeather

      expect(response.daily_weather).to be_a Array
      expect(response.daily_weather[0]).to be_a DailyWeather
      expect(response.daily_weather.count).to eq(5)

      expect(response.hourly_weather).to be_a Array
      expect(response.hourly_weather[0]).to be_a HourlyWeather
      expect(response.hourly_weather.count).to eq(8)
    end
  end
end
