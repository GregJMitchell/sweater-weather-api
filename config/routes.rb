Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/forecast', to: "forecast#show"
      get '/backgrounds', to: 'backgrounds#show'
      resources :users, only: %i[create]
      resources :sessions, only: %i[create]
      resources :road_trip, only: %i[create]
      get '/munchies', to: 'munchies#index'
    end
  end
end
