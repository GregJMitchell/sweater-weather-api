class Api::V1::ForcastController < ApplicationController
  def show
    cords = MapQuestFacade.get_cords(params[:location])
    weather = WeatherFacade.get_weather(cords[:lat], cords[:lng])
    render json: ForcastSerializer.new(weather)
  end
end