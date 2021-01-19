class RoadTrip
  attr_reader :id,
              :start_city,
              :end_city,
              :travel_time,
              :weather_at_eta

  def initialize(data, start_city, end_city)
    @id = nil
    @start_city = start_city
    @end_city = end_city
    @travel_time = data[:route][:formattedTime]
    @weather_at_eta = nil
  end

  def add_weather(weather)
    @weather_at_eta = weather
  end
end
