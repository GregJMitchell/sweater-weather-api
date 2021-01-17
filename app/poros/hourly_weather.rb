class HourlyWeather
  attr_reader :time,
              :temperature,
              :wind_speed,
              :wind_direction,
              :conditions,
              :icon

  def initialize(hour, timezone)
    @time = parse_time(hour, :dt, timezone)
    @temperature = convert_temp(hour[:temp])
    @wind_speed = hour[:wind_speed].to_s
    @wind_direction = convert_to_cardinal(hour[:wind_deg])
    @conditions = hour[:weather][0][:description]
    @icon = hour[:weather][0][:icon]
  end

  private

  def parse_time(hour, symbol, timezone)
    Time.zone = timezone
    time = Time.zone.at(hour[symbol]).to_s
    time.split(' ')[1]
  end

  def convert_temp(temp)
    (temp / 0.55555556 - 459.67).round(2)
  end

  def convert_to_cardinal(deg)
    val = ((deg / 22.5) + 0.5)
    arr = %w[N NNE NE ENE E ESE SE SSE S SSW SW WSW W WNW NW NNW]
    arr[(val % 16)]
  end
end
