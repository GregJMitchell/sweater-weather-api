class Api::V1::MunchiesController < ApplicationController
  def index
    mapquest_params = { origin: params[:start], destination: params[:end] }
    cords = MapQuestFacade.get_cords(params[:end])
    road_trip = MapQuestFacade.road_trip(mapquest_params)

    if road_trip.instance_of?(RoadTrip)
      munchie = MunchiesFacade.find_munchies(cords, params[:food], road_trip)
      if munchie.instance_of?(Munchie)
        render json: MunchieSerializer.new(munchie)
      else
        render json: { message: 'unsuccessful', error: 'You must provide a food' },
               status: :bad_request
      end
    else
      render json: { message: 'unsuccessful', error: road_trip[:info][:messages].join },
             status: :bad_request
    end
  end
end
