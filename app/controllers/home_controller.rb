class HomeController < ApplicationController
  def index
    @custom = Customization.get_custom('home')
  end

  def about
    @custom = Customization.get_custom('about')
    render :about
  end
end
