class WeatherFacade
  def self.get_weather(lat, lon)
    json = WeatherService.get_weather(lat, lon)
    forcast = Forcast.new
    current_weather = CurrentWeather.new(json)
    next_5_days = json[:daily][0..4].map do |day|
      DailyWeather.new(day, json[:timezone])
    end

    next_8_hours = json[:hourly][0..7].map do |hour|
      HourlyWeather.new(hour, json[:timezone])
    end
    forcast.add_current_weather(current_weather)
    forcast.add_daily_weather(next_5_days)
    forcast.add_hourly_weather(next_8_hours)
    forcast
  end
end
