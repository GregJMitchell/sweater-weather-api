require 'rails_helper'

describe RoadTrip do
  it 'exists' do
    params = {
      origin: 'Denver,Co',
      destination: 'Pueblo,Co'
    }
    json_response = File.read('spec/fixtures/denver_to_pueblo.json')
    parsed = JSON.parse(json_response, symbolize_names: true)

    forcast_response = File.read('spec/fixtures/pueblo_forcast.json')
    parsed_forecast = JSON.parse(forcast_response, symbolize_names: true)

    road_trip_weather = RoadTripWeather.new(parsed_forecast, parsed[:route][:time])
    expect(road_trip_weather.conditions).to eq('overcast clouds')
    expect(road_trip_weather.temperature).to eq(39.58)
  end
end
