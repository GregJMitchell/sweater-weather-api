class WeatherService
  def self.get_weather(lat, lon)
    conn = Faraday.new("https://api.openweathermap.org/data/2.5/onecall?lat=#{lat}&lon=#{lon}&appid=#{ENV['OW_API_KEY']}")
    results = conn.get
    JSON.parse(results.body, symbolize_names: true)
  end
end
