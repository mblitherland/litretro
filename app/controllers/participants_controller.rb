class ParticipantsController < ApplicationController
  before_action :authenticate_user!

  def create
    @retro = Retro.find(params[:retro_id])
    if @retro[:user_id] == current_user.id
      params[:participant][:email].split(%r{,\s*}) do |email|
        user ||= User.where(email: email).first
        @retro.participants.create({
          retro_id: params[:retro_id],
          email: email,
          user_id: user ? user[:id] : nil
        })
      end
      redirect_to @retro
    else
      redirect_to retros_path, alert: 'Not permitted'
    end
  end

  private

  def participant_params
    params.require(:participant).permit(:email)
  end
end
