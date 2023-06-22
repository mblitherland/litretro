class PointingController < ApplicationController
  before_action :authenticate_user!

  def index
    @retro = Retro.find(params[:id])

    if @retro.user_allowed(current_user.id)
      render
    else
      redirect_to "/retros", status: 403
    end
  end
end
