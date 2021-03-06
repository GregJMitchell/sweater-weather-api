require 'rails_helper'

describe MapQuestService do
  describe 'class methods' do
    before :each do
      json_response = File.read('spec/fixtures/denver_mapquest_search.json')
      stub_request(:get, "#{ENV['MAPQUEST_URL']}?key=#{ENV['MAPQUEST_API_KEY']}&inFormat=kvp&outFormat=json&location=denver%2C+co&thumbMaps=false")
        .to_return(status: 200, body: json_response)
    end
    it '.get_cords' do
      response = MapQuestService.get_cords('denver', 'co')

      expect(response).to be_a Hash
      expect(response.count).to eq(3)

      expect(response[:results][0][:locations][0][:displayLatLng][:lat]).to be_a Float
      expect(response[:results][0][:locations][0][:displayLatLng][:lng]).to be_a Float
    end

    it '.road_trip' do
      json_response = File.read('spec/fixtures/denver_to_pueblo.json')
      stub_request(:get, "http://open.mapquestapi.com/directions/v2/route?from=Denver,Co&key=#{ENV['MAPQUEST_API_KEY']}&to=Pueblo,Co")
        .to_return(status: 200, body: json_response)
      params = {
        origin: 'Denver,Co',
        destination: 'Pueblo,Co'
      }
      response = MapQuestService.road_trip(params)
      expect(response).to be_a Hash
      expect(response.count).to eq(2)
    end
  end
end
