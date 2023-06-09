class IcebreakersController < ApplicationController
  before_action :authenticate_user!

  def new
    @icebreaker = Icebreaker.new
  end

  def create
    @retro = Retro.find(params[:retro_id])
    if @retro[:user_id] == current_user.id
      if @retro.icebreaker.nil?
        @retro.icebreaker = Icebreaker.new
      end
      @retro.icebreaker.question = params[:icebreaker][:question]
      @retro.icebreaker.save
    else
      redirect_to retros_path, status: :forbidden
    end
    redirect_to @retro
  end
end
