class IcebreakersController < ApplicationController
  def new
    @icebreaker = Icebreaker.new
  end

  def create
    @retro = Retro.find(params[:retro_id])
    if @retro[:user_id] == current_user.id
      if @retro.icebreaker.nil?
        @retro.icebreaker = Icebreaker.new
      end
      @retro.icebreaker.question = params[:question]
    else
      redirect_to retros_path, status: :forbidden
    end
  end
end
