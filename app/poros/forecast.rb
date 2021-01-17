class Forecast
  attr_reader :id,
              :current_weather,
              :daily_weather,
              :hourly_weather

  def initialize
    @id = nil
    @current_weather = nil
    @daily_weather = nil
    @hourly_weather = nil
  end

  def add_current_weather(current_weather)
    @current_weather = current_weather
  end

  def add_daily_weather(days)
    @daily_weather = days
  end

  def add_hourly_weather(hours)
    @hourly_weather = hours
  end
end
