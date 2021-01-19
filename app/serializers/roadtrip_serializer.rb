class RoadtripSerializer
  include JSONAPI::Serializer
  attributes :start_city, :end_city, :travel_time

  attribute :weather_at_eta do |roadtrip|
    {
      temperature: roadtrip.weather_at_eta.temperature,
      conditions: roadtrip.weather_at_eta.conditions
    }
  end
end
