class HomeController < ApplicationController
  def index
    if current_user.nil?
      render
    else
      redirect_to weather_path
    end
  end
end
