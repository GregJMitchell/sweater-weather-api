require 'rails_helper'

describe BackgroundService do
  describe 'class methods' do
    before :each do
      json_response = File.read('spec/fixtures/denver_image_search.json')
      stub_request(:get, "#{ENV['UNSPLASH_URL']}/search/photos/?client_id=#{ENV['UNSPLASH_API_KEY']}&query=denver&page=1&per_page=1")
        .to_return(status: 200, body: json_response)
    end
    it '.search' do
      response = BackgroundService.search('denver')
      expect(response).to be_a Hash

      expect(response[:results].count).to eq(1)

      expect(response[:results][0]).to have_key(:urls)
      expect(response[:results][0]).to have_key(:user)
    end
  end
end
