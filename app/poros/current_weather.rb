class CurrentWeather
  attr_reader :date_time,
              :sunrise,
              :sunset,
              :temperature,
              :feels_like,
              :humidity,
              :uvi,
              :visibility,
              :conditions,
              :icon

  def initialize(data)
    @date_time = parse_time(data, :dt)
    @sunrise = parse_time(data, :sunrise)
    @sunset = parse_time(data, :sunset)
    @temperature = convert_temp(data[:current][:temp])
    @feels_like = convert_temp(data[:current][:temp])
    @humidity = data[:current][:humidity]
    @uvi = data[:current][:uvi]
    @visibility = data[:current][:visibility]
    @conditions = data[:current][:weather][0][:description]
    @icon = data[:current][:weather][0][:icon]
  end

  private

  def parse_time(data, symbol)
    Time.zone = data[:timezone]
    Time.zone.at(data[:current][symbol]).to_s
  end

  def convert_temp(temp)
    (temp / 0.55555556 - 459.67).round(2)
  end
end
