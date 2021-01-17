class MapQuestService
  def self.get_cords(city, state)
    conn = Faraday.new("#{ENV['MAPQUEST_URL']}?key=#{ENV['MAPQUEST_API_KEY']}&inFormat=kvp&outFormat=json&location=#{city}%2C+#{state}&thumbMaps=false")
    results = conn.get
    JSON.parse(results.body, symbolize_names: true)
  end
end