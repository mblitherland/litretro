class ParticipantsController < ApplicationController
  def create
    @retro = Retro.find(params[:retro_id])
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
  end

  private

  def participant_params
    params.require(:participant).permit(:email)
  end
end
