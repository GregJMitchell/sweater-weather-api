require 'rails_helper'

describe RoadTrip do
  it 'exists' do
    params = {
      origin: 'Denver,Co',
      destination: 'Pueblo,Co'
    }
    json_response = File.read('spec/fixtures/denver_to_pueblo.json')
    parsed = JSON.parse(json_response, symbolize_names: true)

    road_trip = RoadTrip.new(parsed, params[:origin], params[:destination])
    expect(road_trip.end_city).to eq('Pueblo,Co')
    expect(road_trip.start_city).to eq('Denver,Co')
    expect(road_trip.travel_time).to eq('01:44:35')
  end
end
