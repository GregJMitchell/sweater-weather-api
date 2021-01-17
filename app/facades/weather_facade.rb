class WeatherFacade
  def self.get_weather(lat, lon)
    json = WeatherService.get_weather(lat, lon)
    forecast = Forecast.new
    current_weather = CurrentWeather.new(json)
    next_5_days = json[:daily][0..4].map do |day|
      DailyWeather.new(day, json[:timezone])
    end

    next_8_hours = json[:hourly][0..7].map do |hour|
      HourlyWeather.new(hour, json[:timezone])
    end
    forecast.add_current_weather(current_weather)
    forecast.add_daily_weather(next_5_days)
    forecast.add_hourly_weather(next_8_hours)
    forecast
  end
end
