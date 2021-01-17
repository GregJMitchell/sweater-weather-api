class Api::V1::ForecastController < ApplicationController
  def show
    cords = MapQuestFacade.get_cords(params[:location])
    weather = WeatherFacade.get_weather(cords[:lat], cords[:lng])
    render json: ForecastSerializer.new(weather)
  end
end