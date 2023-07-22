# frozen_string_literal: true

require 'uri'
require 'net/http'

class WeatherService
  API_KEY = 'API_key'
  BASE_URL = 'https://api.openweathermap.org/data/2.5/weather'

  def get_weather_by_city(city_name)
    begin
      params = { q: city_name, appid: API_KEY }
      url = URI(BASE_URL)
      url.query = URI.encode_www_form(params)
      response = Net::HTTP.get(url)
    rescue Exception
      raise StandardError.new("#{BASE_URL} API did not respond. Please try again later")
    else
      JSON.parse(response)
    end
  end
end
