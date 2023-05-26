class RetrosController < ApplicationController
  before_action :authenticate_user!

  def index
    @retros = Retro.all
  end

  def show
    @retro = Retro.find(params[:id])
  end

  def new
    @retro = Retro.new
  end

  def create
    @retro = Retro.new(retro_params)

    if @retro.save
      redirect_to @retro
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def retro_params
    params.require(:retro).permit(:description, :retro_date)
  end
end
