require 'rails_helper'

describe BackgroundFacade do
  describe 'class methods' do
    before :each do
      json_response = File.read('spec/fixtures/denver_image_search.json')
      stub_request(:get, "#{ENV['UNSPLASH_URL']}/search/photos/?client_id=#{ENV['UNSPLASH_API_KEY']}&query=denver&page=1&per_page=1")
        .to_return(status: 200, body: json_response)
    end
    it '.search' do
      response = BackgroundFacade.search('denver,co')
      expect(response).to be_a Image

      expect(response.id).to eq(nil)

      expect(response.location).to be_a String
      expect(response.image_url).to be_a String
      expect(response.credit).to be_a Hash

      expect(response.credit).to have_key(:source)
      expect(response.credit[:source]).to be_a String

      expect(response.credit).to have_key(:author_name)
      expect(response.credit[:author_name]).to be_a String

      expect(response.credit).to have_key(:author_username)
      expect(response.credit[:author_username]).to be_a String

      expect(response.credit).to have_key(:logo)
      expect(response.credit[:logo]).to be_a String
    end
  end
end
