class WeatherController < ApplicationController
  before_action :set_weather_service, only: :show

  def show
    city_name = params[:city]

    if city_name.present?
      weather_data = @weather_service.get_weather_by_city(city_name)
      if weather_data.present? && weather_data['cod'] < 400
        @temperature = (weather_data.dig('main', 'temp') - 273.15).round(2)
        @description = weather_data.dig('weather', 0, 'description')
      end
    end
  end

  private

  def set_weather_service
    @weather_service = WeatherService.new
  end
end
