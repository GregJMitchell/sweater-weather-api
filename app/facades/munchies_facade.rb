class MunchiesFacade
  def self.find_munchies(cords, food, road_trip)
    json = MunchiesService.find_munchies(cords[:lat], cords[:lng], food)
    Munchie.new(json, road_trip)
  end
end
