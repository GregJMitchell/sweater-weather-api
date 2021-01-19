class Api::V1::ForecastController < ApplicationController
  def show
    cords = MapQuestFacade.get_cords(params[:location])
    weather = WeatherFacade.get_weather(cords[:lat], cords[:lng])
    if weather.instance_of?(Forecast)
      render json: ForecastSerializer.new(weather)
    else
      render json: { message: 'unsuccessful', error: weather[:message] },
             status: :bad_request
    end
  end
end
