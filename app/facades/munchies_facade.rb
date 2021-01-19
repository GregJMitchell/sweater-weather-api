class MunchiesFacade
  def self.find_munchies(cords, food, road_trip)
    Time.zone = road_trip.weather_at_eta.timezone
    time_at_arrival = Time.zone.now.advance(hours: road_trip.weather_at_eta.time)
    if food != ''
      json = MunchiesService.find_munchies(cords[:lat], cords[:lng], food, time_at_arrival.to_i)
      if json[:businesses].empty?
        return nil
      else
        Munchie.new(json, road_trip)
      end
    else
      nil
    end
  end
end
