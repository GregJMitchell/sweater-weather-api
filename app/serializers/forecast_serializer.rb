class ForecastSerializer
  include JSONAPI::Serializer

  attribute :current_weather do |forecast|
    {
      date_time: forecast.current_weather.date_time,
      sunrise: forecast.current_weather.sunrise,
      sunset: forecast.current_weather.sunset,
      temperature: forecast.current_weather.temperature,
      feels_like: forecast.current_weather.feels_like,
      humidity: forecast.current_weather.humidity,
      uvi: forecast.current_weather.uvi,
      visibility: forecast.current_weather.visibility,
      conditions: forecast.current_weather.conditions,
      icon: forecast.current_weather.icon
    }
  end

  attribute :daily_weather do |forecast|
    forecast.daily_weather.map do |day|
      {
        date_time: day.date,
        sunrise: day.sunrise,
        sunset: day.sunset,
        max_temp: day.max_temp,
        min_temp: day.min_temp,
        conditions: day.conditions,
        icon: day.icon
      }
    end
  end

  attribute :hourly_weather do |forecast|
    forecast.hourly_weather.map do |hour|
      {
        time: hour.time,
        temperature: hour.temperature,
        wind_speed: hour.wind_speed,
        wind_direction: hour.wind_direction,
        conditions: hour.conditions,
        icon: hour.icon
      }
    end
  end
end
