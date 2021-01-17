class DailyWeather
  attr_reader :date,
              :sunrise,
              :sunset,
              :max_temp,
              :min_temp,
              :conditions,
              :icon

  def initialize(day, timezone)
    @date = parse_time(day, :dt, timezone)
    @sunrise = parse_time(day, :sunrise, timezone)
    @sunset = parse_time(day, :sunset, timezone)
    @max_temp = convert_temp(day[:temp][:max])
    @min_temp = convert_temp(day[:temp][:min])
    @conditions = day[:weather][0][:description]
    @icon = day[:weather][0][:icon]
  end

  private

  def parse_time(day, symbol, timezone)
    Time.zone = timezone
    Time.zone.at(day[symbol]).to_s
  end

  def convert_temp(temp)
    (temp / 0.55555556 - 459.67).round(2)
  end
end
