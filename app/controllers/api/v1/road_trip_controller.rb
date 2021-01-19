class Api::V1::RoadTripController < ApplicationController
  def create
    mapquest_params = JSON.parse(request.body.string, symbolize_names: true)
    if User.find_by(api_key: mapquest_params[:api_key])
      road_trip = MapQuestFacade.road_trip(mapquest_params)

      if road_trip.instance_of?(RoadTrip)
        render json: RoadtripSerializer.new(road_trip)
      else
        render json: { message: 'unsuccessful', error: road_trip[:info][:messages].join },
               status: :bad_request
      end
    else
      render json: { message: 'unsuccessful', error: 'Api Key is incorrect' },
             status: :unauthorized
    end
  end
end
