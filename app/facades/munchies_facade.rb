class MunchiesFacade
  def self.find_munchies(cords, food, road_trip)
    if food != ''
      json = MunchiesService.find_munchies(cords[:lat], cords[:lng], food)
      Munchie.new(json, road_trip)
    else
      nil
    end
  end
end
