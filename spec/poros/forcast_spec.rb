require 'rails_helper'

RSpec.describe Forcast do
  it 'exists' do
    forcast = Forcast.new

    expect(forcast.id).to eq(nil)
    expect(forcast.current_weather).to eq(nil)
    expect(forcast.daily_weather).to eq(nil)
    expect(forcast.hourly_weather).to eq(nil)

    forcast.add_current_weather('testing')
    forcast.add_daily_weather([1, 2])
    forcast.add_hourly_weather([3, 4])

    expect(forcast.current_weather).to eq('testing')
    expect(forcast.daily_weather).to eq([1, 2])
    expect(forcast.hourly_weather).to eq([3, 4])
  end
end
