class BackgroundService
  def self.search(city)
    conn = Faraday.new("#{ENV['UNSPLASH_URL']}/search/photos/?client_id=#{ENV['UNSPLASH_API_KEY']}&query=#{city}&page=1&per_page=1")
    results = conn.get
    JSON.parse(results.body, symbolize_names: true)
  end
end