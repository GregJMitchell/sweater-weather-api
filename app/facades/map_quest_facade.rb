class MapQuestFacade
  def self.get_cords(location)
    city = location.split(',')[0]
    state = location.split(',')[1]
    json = MapQuestService.get_cords(city, state)

    if json[:info][:statuscode] == 0
      json[:results][0][:locations][0][:displayLatLng]
    else
      json
    end
  end

  def self.road_trip(params)
    json = MapQuestService.road_trip(params)
    if json[:info][:statuscode] == 0
      road_trip = RoadTrip.new(json, params[:origin], params[:destination])
      weather = WeatherService.get_weather(json[:route][:locations].last[:displayLatLng][:lat],
                                           json[:route][:locations].last[:displayLatLng][:lng])
      rt_weather = RoadTripWeather.new(weather, json[:route][:time])
      road_trip.add_weather(rt_weather)
      road_trip
    else
      json
    end
  end
end
