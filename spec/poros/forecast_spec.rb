require 'rails_helper'

RSpec.describe Forecast do
  it 'exists' do
    forecast = Forecast.new

    expect(forecast.id).to eq(nil)
    expect(forecast.current_weather).to eq(nil)
    expect(forecast.daily_weather).to eq(nil)
    expect(forecast.hourly_weather).to eq(nil)

    forecast.add_current_weather('testing')
    forecast.add_daily_weather([1, 2])
    forecast.add_hourly_weather([3, 4])

    expect(forecast.current_weather).to eq('testing')
    expect(forecast.daily_weather).to eq([1, 2])
    expect(forecast.hourly_weather).to eq([3, 4])
  end
end
