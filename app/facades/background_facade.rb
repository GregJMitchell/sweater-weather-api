class BackgroundFacade
  def self.search(search)
    city = search.split(',')[0]
    json = BackgroundService.search(city)
    Image.new(json[:results][0], search)
  end
end
