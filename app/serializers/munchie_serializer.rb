class MunchieSerializer
  include JSONAPI::Serializer
  attributes :destination_city, :travel_time

  attribute :forecast do |munchie|
    {
      summary: munchie.forecast.conditions,
      temperature: munchie.forecast.temperature
    }
  end
  attribute :resturant do |munchie|
    {
      name: munchie.resturant[:name],
      address: munchie.resturant[:address]
    }
  end
end
