require 'rails_helper'

describe 'Munchies endpoint' do
  describe 'GET /api/v1/munchies?start=CITY,STATE&end=city,state&food=foodtype' do
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
    it 'Can return data' do
      get '/api/v1/munchies?start=denver,co&end=pueblo,co&food=chinese'

      expect(response.status).to eq(200)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:data][:type]).to eq('munchie')
      expect(json[:data][:id]).to eq(nil)
      expect(json[:data]).to have_key(:attributes)
      expect(json[:data][:attributes]).to have_key(:destination_city)
      expect(json[:data][:attributes]).to have_key(:travel_time)
      expect(json[:data][:attributes]).to have_key(:forecast)
      expect(json[:data][:attributes][:forecast]).to have_key(:temperature)
      expect(json[:data][:attributes][:forecast]).to have_key(:summary)
      expect(json[:data][:attributes]).to have_key(:resturant)
      expect(json[:data][:attributes][:resturant]).to have_key(:name)
      expect(json[:data][:attributes][:resturant]).to have_key(:address)
    end
  end
end
