class ParticipantsController < ApplicationController
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
      # @participant = @retro.participants.create(participant_params)
      redirect_to retro_path(@retro)
    else
      redirect_to retros_path, status: :forbidden
    end
  end

  private

  def participant_params
    params.require(:participant).permit(:email)
  end
end
