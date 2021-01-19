class RoadTripWeather
  attr_reader :temperature,
              :conditions,
              :timezone,
              :time

  def initialize(weather, time)
    @time = parse_time(time)
    @timezone = weather[:timezone]
    @temperature = get_temp(weather)
    @conditions = weather[:hourly][@time][:weather].first[:description]
  end

  private

  def parse_time(time)
    (time / 3600.0).round(0)
  end

  def get_temp(weather)
    temp = weather[:hourly][@time][:temp]
    convert_temp(temp)
  end

  def convert_temp(temp)
    (temp / 0.55555556 - 459.67).round(2)
  end
end
