class ForcastSerializer
  include JSONAPI::Serializer

  attribute :current_weather do |forcast|
    {
      date_time: forcast.current_weather.date_time,
      sunrise: forcast.current_weather.sunrise,
      sunset: forcast.current_weather.sunset,
      temperature: forcast.current_weather.temperature,
      feels_like: forcast.current_weather.feels_like,
      humidity: forcast.current_weather.humidity,
      uvi: forcast.current_weather.uvi,
      visibility: forcast.current_weather.visibility,
      conditions: forcast.current_weather.conditions,
      icon: forcast.current_weather.icon
    }
  end

  attribute :daily_weather do |forcast|
    forcast.daily_weather.map do |day|
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

  attribute :hourly_weather do |forcast|
    forcast.hourly_weather.map do |hour|
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
