class MapQuestService
  def self.get_cords(city, state)
    conn = Faraday.new("#{ENV['MAPQUEST_URL']}?key=#{ENV['MAPQUEST_API_KEY']}&inFormat=kvp&outFormat=json&location=#{city}%2C+#{state}&thumbMaps=false")
    results = conn.get
    JSON.parse(results.body, symbolize_names: true)
  end

  def self.road_trip(params)
    conn = Faraday.new("#{ENV['MAPQUEST_DIRECTIONS_URL']}?key=#{ENV['MAPQUEST_API_KEY']}&from=#{params[:origin]}&to=#{params[:destination]}")
    results = conn.get
    JSON.parse(results.body, symbolize_names: true)
  end
end
