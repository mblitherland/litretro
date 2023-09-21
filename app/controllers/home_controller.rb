class HomeController < ApplicationController
  def index
  end

  def about
    @custom = Customization.get_custom('about')
    render :about
  end
end
