# Sweater Weather API


* Ruby version `2.5.3`
* Rails Version `5.2.4.3`
## How to run locally
1. clone down `git clone https://github.com/GregJMitchell/sweater-weather-api.git`
1. Run `bundle install` to install all gems
1. Use the `figaro install` command and add the following things to the application.yml
    ```OW_API_KEY: (get your own key. linked below)
      OW_URL: https://api.openweathermap.org/data/2.5/onecall
      MAPQUEST_URL: https://www.mapquestapi.com/geocoding/v1/address
      MAPQUEST_API_KEY: (get your own key. linked below)
      MAPQUEST_DIRECTIONS_URL: http://open.mapquestapi.com/directions/v2/route
      UNSPLASH_API_KEY: (get your own key. linked below)
      UNSPLASH_URL: https://api.unsplash.com/
    ```
    * [OW_API_KEY](https://openweathermap.org/api/one-call-api)
    * [MAPQUEST_API_KEY](https://developer.mapquest.com/)
    * [UNSPLASH_API_KEY](https://unsplash.com/developers)
1. Run `rails s` to start development server
1. Access the API using a tool like postman at port `http://localhost:3000`
## Endpoints
1. `GET /api/v1/forecast?location=denver,co`
    * This endpoint takes a location as a query parameter and returns a serialized json response as shown below. The response has the current weather, the next five days of weather, and the next 8 hours of weather.
```
  {
  "data": {
    "id": null,
    "type": "forecast",
    "attributes": {
      "current_weather": {
        "datetime": "2020-09-30 13:27:03 -0600",
        "temperature": 79.4,
        etc
      },
      "daily_weather": [
        {
          "date": "2020-10-01",
          "sunrise": "2020-10-01 06:10:43 -0600",
          etc
        },
        {...} etc
      ],
      "hourly_weather": [
        {
          "time": "14:00:00",
          "wind_speed": "4 mph",
          "wind_direction": "from NW",
          etc
        },
        {...} etc
      ]
    }
  }
}
```
1. `GET /api/v1/backgrounds?location=denver,co`
    * This endpoint takes a location as a query parameter and returns the URL of a photo of that city along with other information about the author.
```
{
  "data": {
    "type": "image",
    "id": null,
    "attributes": {
      "image": {
        "location": "denver,co",
        "image_url": "https://pixabay.com/get/54e6d4444f50a814f1dc8460962930761c38d6ed534c704c7c2878dd954dc451_640.jpg",
        "credit": {
          "source": "pixabay.com",
          "author": "quinntheislander",
          "logo": "https://pixabay.com/static/img/logo_square.png"
        }
      }
    }
  }
}
```
1. `POST /api/v1/users`
    * Endpoint to register a user. Returns an api key for the new user to access the road trips endpoint.
```
Request
{
  "email": "whatever@example.com",
  "password": "password",
  "password_confirmation": "password"
}
```
```
Response
{
  "data": {
    "type": "users",
    "id": "1",
    "attributes": {
      "email": "whatever@example.com",
      "api_key": "jgn983hy48thw9begh98h4539h4"
    }
  }
}
```
1. `POST /api/v1/sessions`
    * Finds the user in the database if the exist. Returns thier api key with the response.
```
Request
{
  "email": "whatever@example.com",
  "password": "password"
}
```
```
Response
{
  "data": {
    "type": "users",
    "id": "1",
    "attributes": {
      "email": "whatever@example.com",
      "api_key": "jgn983hy48thw9begh98h4539h4"
    }
  }
}
```
1. `POST /api/v1/road_trip`
    * Send two cities and your api key to this endpoint to recieve a response that has the time of the road trip and the weather of the destination city at the time of your arrival.
```
Request
{
  "origin": "Denver,CO",
  "destination": "Pueblo,CO",
  "api_key": "jgn983hy48thw9begh98h4539h4"
}
```
```
Response
{
  "data": {
    "id": null,
    "type": "roadtrip",
    "attributes": {
      "start_city": "Denver, CO",
      "end_city": "Estes Park, CO",
      "travel_time": "2 hours, 13 minutes"
      "weather_at_eta": {
        "temperature": 59.4,
        "conditions": "partly cloudy with a chance of meatballs"
      }
    }
  }
}
```
