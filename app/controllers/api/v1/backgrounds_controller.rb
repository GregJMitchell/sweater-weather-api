class Api::V1::BackgroundsController < ApplicationController
  def show
    image = BackgroundFacade.search(params[:location])
    render json: ImageSerializer.new(image)
  end
end