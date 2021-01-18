class Api::V1::UsersController < ApplicationController
  def create
    user_params = JSON.parse(request.body.string, symbolize_names: true)

    user = User.create(email: user_params[:email],
                       password: user_params[:password],
                       password_confirmation: user_params[:password_confirmation])

    if user.save
      render json: UsersSerializer.new(user)
    elsif User.find_by(email: user_params[:email])
      render json: { message: 'unsuccessful', error: 'User already exists' },
             status: :conflict
    else
      render json: { message: 'unsuccessful', error: 'Could not create user' },
             status: :unprocessable_entity
    end
  end
end
