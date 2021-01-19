require 'rails_helper'

describe 'Munchies endpoint' do
  describe 'GET /api/v1/munchies?start=CITY,STATE&end=city,state&food=foodtype' do
    before :each do
      json_response = File.read('spec/fixtures/denver_to_pueblo.json')
      stub_request(:get, "http://open.mapquestapi.com/directions/v2/route?from=Denver,Co&key=#{ENV['MAPQUEST_API_KEY']}&to=Pueblo,Co")
        .to_return(status: 200, body: json_response)
      forcast_response = File.read('spec/fixtures/pueblo_forcast.json')
      stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall?appid=#{ENV['OW_API_KEY']}&lat=38.254448&lon=-104.609138")
        .to_return(status: 200, body: forcast_response)
      munchies_response = File.read('spec/fixtures/pueblo_munchies.json')
      stub_request(:get, 'https://api.yelp.com/v3/businesses/search?latitude=38.254447&longitude=-104.609141&categories=resturants,chinese')
        .to_return(status: 200, body: munchies_response)
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
      expect(json[:data][:attributes]).to have_key(:resurant)
      expect(json[:data][:attributes][:resurant]).to have_key(:name)
      expect(json[:data][:attributes][:resurant]).to have_key(:address)
    end
  end
end
