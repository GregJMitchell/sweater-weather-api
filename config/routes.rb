Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/forcast', to: "forcast#show"
    end
  end
end
