class MunchiesService
  def self.find_munchies(lat, lon, food)
    conn = Faraday.new("https://api.yelp.com/v3/businesses/search?latitude=#{lat}&longitude=#{lon}&categories=resturants,#{food}")
    conn.authorization :Bearer, (ENV['YELP_API_KEY']).to_s
    conn.headers['Authorization']
    results = conn.get
    JSON.parse(results.body, symbolize_names: true)
  end
end
