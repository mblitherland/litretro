class WelcomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @retro = Retro.find(params[:id])

    # TODO: Make sure this user is actually allowed to access this retro
  end
end
