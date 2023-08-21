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
      redirect_to "/retros/#{@retro.id}/icebreaker"
    else
      redirect_to retros_path, alert: 'Not permitted'
    end
  end
end
