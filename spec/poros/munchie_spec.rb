require 'rails_helper'

RSpec.describe Munchie do
  before :each do
    pueblo_response = File.read('spec/fixtures/pueblo_mapquest_search.json')
    stub_request(:get, "#{ENV['MAPQUEST_URL']}?key=#{ENV['MAPQUEST_API_KEY']}&inFormat=kvp&outFormat=json&location=pueblo%2C+co&thumbMaps=false")
      .to_return(status: 200, body: pueblo_response)
    json_response = File.read('spec/fixtures/denver_to_pueblo.json')
    stub_request(:get, "http://open.mapquestapi.com/directions/v2/route?from=denver,co&key=#{ENV['MAPQUEST_API_KEY']}&to=pueblo,co")
      .to_return(status: 200, body: json_response)
    forcast_response = File.read('spec/fixtures/pueblo_forcast.json')
    stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=#{ENV['OW_API_KEY']}&lat=38.254448&lon=-104.609138")
      .to_return(status: 200, body: forcast_response)
    munchies_response = File.read('spec/fixtures/pueblo_munchies.json')
    stub_request(:get, 'https://api.yelp.com/v3/businesses/search?categories=resturants,chinese&latitude=38.265425&longitude=-104.610415')
      .with(
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization' => "Bearer #{ENV['YELP_API_KEY']}",
          'User-Agent' => 'Faraday v1.3.0'
        }
      )
      .to_return(status: 200, body: munchies_response, headers: {})
  end
  it 'exists' do
    json = File.read('spec/fixtures/pueblo_munchies.json')
    parsed = JSON.parse(json, symbolize_names: true)

    params = {
      origin: 'denver,co',
      destination: 'pueblo,co'
    }
    json = MapQuestService.road_trip(params)
    road_trip = RoadTrip.new(json, params[:origin], params[:destination])
    weather = WeatherService.get_weather(json[:route][:locations].last[:displayLatLng][:lat],
                                         json[:route][:locations].last[:displayLatLng][:lng])
    rt_weather = RoadTripWeather.new(weather, json[:route][:time])
    road_trip.add_weather(rt_weather)

    munchie = Munchie.new(parsed, road_trip)

    expect(munchie.id).to eq(nil)

    expect(munchie.destination_city).to eq('pueblo,co')

    expect(munchie.forecast).to be_a RoadTripWeather

    expect(munchie.forecast.conditions).to eq("overcast clouds")
    expect(munchie.forecast.temperature).to eq(39.58)

    expect(munchie.travel_time).to eq('01:44:35')

    expect(munchie.resturant).to be_a Hash
    expect(munchie.resturant[:name]).to be_a String
    expect(munchie.resturant[:name]).to eq("Kan's Kitchen")

    expect(munchie.resturant[:address]).to be_a String
    expect(munchie.resturant[:address]).to eq("1620 S Prairie Ave, Pueblo, CO 81005")
  end
end
