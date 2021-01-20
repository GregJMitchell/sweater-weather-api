require 'rails_helper'

describe MapQuestFacade do
  describe 'class methods' do
    before :each do
      json_response = File.read('spec/fixtures/denver_mapquest_search.json')
      stub_request(:get, "#{ENV['MAPQUEST_URL']}?key=#{ENV['MAPQUEST_API_KEY']}&inFormat=kvp&outFormat=json&location=denver%2C+co&thumbMaps=false")
        .to_return(status: 200, body: json_response)
    end
    it '.get_cords' do
      response = MapQuestFacade.get_cords('denver,co')
      expect(response).to be_a Hash
      expect(response.count).to eq(2)

      expect(response[:lat]).to be_a Float
      expect(response[:lng]).to be_a Float
    end

    it '.road_trip' do
      json_response = File.read('spec/fixtures/denver_to_pueblo.json')
      stub_request(:get, "http://open.mapquestapi.com/directions/v2/route?from=Denver,Co&key=#{ENV['MAPQUEST_API_KEY']}&to=Pueblo,Co")
        .to_return(status: 200, body: json_response)
      forcast_response = File.read('spec/fixtures/pueblo_forcast.json')
      stub_request(:get, 'https://api.openweathermap.org/data/2.5/onecall?appid=37b66c6ee992a7188c0682f0fe3cbffa&lat=38.254448&lon=-104.609138')
        .to_return(status: 200, body: forcast_response)
      params = {
        origin: 'Denver,Co',
        destination: 'Pueblo,Co'
      }

      response = MapQuestFacade.road_trip(params)

      expect(response).to be_a RoadTrip
    end
  end
end
