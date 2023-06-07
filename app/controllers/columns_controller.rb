class ColumnsController < ApplicationController
  def create
    @retro = Retro.find(params[:retro_id])
    if @retro[:user_id] == current_user.id
      if @retro.theme.nil?
        @retro.theme = Column.new
      end
      @retro.theme.question = params[:theme][:columns]
      @retro.theme.save
    else
      redirect_to retros_path, status: :forbidden
    end
    redirect_to @retro
  end
end
