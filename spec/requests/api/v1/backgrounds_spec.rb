require 'rails_helper'

describe 'api/v1/backgrounds' do
  describe 'GET /api/v1/backgrounds' do
    before :each do
      json_response = File.read('spec/fixtures/denver_image_search.json')
      stub_request(:get, "#{ENV['UNSPLASH_URL']}/search/photos/?client_id=#{ENV['UNSPLASH_API_KEY']}&query=denver&page=1&per_page=1")
        .to_return(status: 200, body: json_response)
    end

    it 'retrieves an appropriate background for a location' do
      get '/api/v1/backgrounds?location=denver,co'

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      expect(json[:data][:id]).to be_nil
      expect(json[:data][:type]).to eq('image')

      expect(json[:data][:attributes][:image][:location]).to eq('Denver, Co')

      expect(json[:data][:attributes][:image]).to have_key(:image_url)
      expect(json[:data][:attributes][:image]).to have_key(:credit)
    end
  end
end
