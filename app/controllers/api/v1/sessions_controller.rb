class Api::V1::SessionsController < ApplicationController
  def create
    user_params = JSON.parse(request.body.string, symbolize_names: true)
    user = User.find_by(email: user_params[:email])
    if user&.authenticate(user_params[:password])
      session[:user_id] = user.id
      render json: UsersSerializer.new(user)
    else
      render json: { message: 'unsuccessful', error: 'Email/Password is incorrect' },
             status: :unauthorized
    end
  end
end
