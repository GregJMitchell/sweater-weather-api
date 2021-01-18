class MapQuestFacade
  def self.get_cords(location)
    city = location.split(',')[0]
    state = location.split(',')[1]
    json = MapQuestService.get_cords(city, state)
    json[:results][0][:locations][0][:displayLatLng]
  end
end
