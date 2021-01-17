require 'rails_helper'

RSpec.describe HourlyWeather do
  it 'exists' do
    json = File.read('spec/fixtures/denver_forcast.json')
    parsed = JSON.parse(json, symbolize_names: true)

    hourly_weather = HourlyWeather.new(parsed[:hourly][0], parsed[:timezone])

    expect(hourly_weather.conditions).to eq('clear sky')
    expect(hourly_weather.time).to eq('15:00:00')
    expect(hourly_weather.temperature).to eq(45.48)
    expect(hourly_weather.icon).to eq('01d')
    expect(hourly_weather.wind_direction).to eq('ESE')
    expect(hourly_weather.wind_speed).to eq('1.83')
  end
end
