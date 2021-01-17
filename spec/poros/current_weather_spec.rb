require 'rails_helper'

RSpec.describe CurrentWeather do
  it 'exists' do
    json = File.read('spec/fixtures/denver_forcast.json')
    parsed = JSON.parse(json, symbolize_names: true)

    current_weather = CurrentWeather.new(parsed)

    expect(current_weather.conditions).to eq('clear sky')
    expect(current_weather.date_time).to eq('2021-01-16 15:00:36 -0700')
    expect(current_weather.feels_like).to eq(45.48)
    expect(current_weather.humidity).to eq(41)
    expect(current_weather.icon).to eq('01d')
    expect(current_weather.sunrise).to eq('2021-01-16 07:18:33 -0700')
    expect(current_weather.sunset).to eq('2021-01-16 17:00:41 -0700')
    expect(current_weather.temperature).to eq(45.48)
    expect(current_weather.uvi).to eq(0.59)
    expect(current_weather.visibility).to eq(10_000)
  end
end
