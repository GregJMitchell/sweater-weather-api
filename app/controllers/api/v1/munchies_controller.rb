class Api::V1::MunchiesController < ApplicationController
  def index
    mapquest_params = {origin: params[:start], destination: params[:end]}
    cords = MapQuestFacade.get_cords(params[:end])
    road_trip = MapQuestFacade.road_trip(mapquest_params)
    munchies = MunchiesFacade.find_munchies(cords, params[:food], road_trip)
    require 'pry'; binding.pry
  end
end