class ActiveController < ApplicationController
  before_action :authenticate_user!

  def index
    @retros = Retro
      .where(user_id: current_user.id)
      .where.not(state: [ "setup", "complete" ])
    @retros += Retro
      .where.not(user_id: current_user.id)
      .where.not(state: [ "setup", "complete" ])
      .joins(:participants)
      .where(participants: { user_id: current_user.id })

    if @retros.length == 1
      redirect_to "/#{@retros[0].state}/#{@retros[0].id}"
    else
      render
    end
  end
end
