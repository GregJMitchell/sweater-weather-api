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
  end
end
