require 'rails_helper'

RSpec.describe DailyWeather do
  it 'exists' do
    json = File.read('spec/fixtures/denver_forcast.json')
    parsed = JSON.parse(json, symbolize_names: true)

    daily_weather = DailyWeather.new(parsed[:daily][0], parsed[:timezone])

    expect(daily_weather.conditions).to eq('clear sky')
    expect(daily_weather.date).to eq('2021-01-16 12:00:00 -0700')
    expect(daily_weather.max_temp).to eq(45.48)
    expect(daily_weather.icon).to eq('01d')
    expect(daily_weather.sunrise).to eq('2021-01-16 07:18:33 -0700')
    expect(daily_weather.sunset).to eq('2021-01-16 17:00:41 -0700')
    expect(daily_weather.min_temp).to eq(34.11)
  end
end
