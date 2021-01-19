class Api::V1::MunchiesController < ApplicationController
  def index
    mapquest_params = {origin: params[:start], destination: params[:end]}
    cords = MapQuestFacade.get_cords(params[:end])
    road_trip = MapQuestFacade.road_trip(mapquest_params)
    munchie = MunchiesFacade.find_munchies(cords, params[:food], road_trip)
    if munchie.instance_of?(Munchie)
      render json: MunchieSerializer.new(munchie)
    else
      render json: { message: 'unsuccessful', error: 'Something went wrong' },
             status: :bad_request
    end
  end
end