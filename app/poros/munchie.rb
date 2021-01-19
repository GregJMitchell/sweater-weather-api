class Munchie
  attr_reader :id,
              :destination_city,
              :travel_time,
              :forecast,
              :resturant

  def initialize(data, road_trip)
    @id = nil
    @destination_city = road_trip.end_city
    @travel_time = road_trip.travel_time
    @forecast = road_trip.weather_at_eta
    @resturant = resturant_info(data[:businesses])
  end

  private

  def resturant_info(data)
    {
      name: data.first[:name],
      address: data.first[:location][:display_address].join(', ')
    }
  end
end
