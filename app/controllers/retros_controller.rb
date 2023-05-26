class RetrosController < ApplicationController
  before_action :authenticate_user!

  def index
    @retros = Retro.order(retro_date: :desc).limit(6)
    @guest_retros = []
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

  def edit
    @retro = Retro.find(params[:id])
  end

  def update
    @retro = Retro.find(params[:id])

    if @retro.update(retro_params)
      redirect_to @retro
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @retro = Retro.find(params[:id])
    @retro.destroy

    redirect_to retros_path, status: :see_other
  end

  private

  def retro_params
    params.require(:retro).permit(:description, :retro_date)
  end
end
