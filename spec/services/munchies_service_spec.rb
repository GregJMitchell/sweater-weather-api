require 'rails_helper'

describe MunchiesService do
  describe 'class methods' do
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
        Time.zone = 'America/Denver'
        @time = Time.zone.now.advance(hours: 2)
      munchies_response = File.read('spec/fixtures/pueblo_munchies.json')
      stub_request(:get, "https://api.yelp.com/v3/businesses/search?categories=resturants,chinese&latitude=38.265425&longitude=-104.610415&open_at=#{@time.to_i}")
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

    it '.find_munchies' do
      cords = {lat: 38.265425, lng: -104.610415}
      

      response = MunchiesService.find_munchies(cords[:lat],cords[:lng], 'chinese', @time.to_i)

      expect(response).to be_a Hash

      expect(response).to have_key(:businesses)
      expect(response[:businesses]).to be_a Array
      expect(response[:businesses].first).to be_a Hash
      expect(response[:businesses].first).to have_key(:name)
      expect(response[:businesses].first).to have_key(:location)
      expect(response[:businesses].first[:location]).to have_key(:display_address)
      expect(response[:businesses].first[:location][:display_address]).to be_a Array
    end
  end
end
