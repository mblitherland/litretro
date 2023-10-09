class ParticipantsController < ApplicationController
  before_action :authenticate_user!

  def create
    @retro = Retro.find(params[:retro_id])
    if @retro[:user_id] == current_user.id
      params[:participant][:email].split(%r{,\s*}) do |email|
        add_participant(email)
      end
      redirect_to @retro, notice: 'Partipant list updated'
    else
      redirect_to retros_path, alert: 'Not permitted'
    end
  end

  def destroy
    @retro = Retro.find(params[:retro_id])
    if @retro[:user_id] == current_user.id
      participant = Participant.find(params[:id])
      participant.delete
      redirect_to @retro, notice: 'Participant removed'
    else
      redirect_to retros_path, alert: 'Not permitted'
    end
  end

  def add_prior
    @retro = Retro.find(params[:id])
    if @retro[:user_id] == current_user.id
      previous = Retro.find(params[:prior_id])
      if previous[:user_id] == current_user.id
        previous.participants.each do |prior|
          next if prior.email.starts_with?('guest_')

          add_participant(prior.email)
        end
        redirect_to @retro, notice: 'Participant list updated'
      else
        redirect_to retros_path, alert: 'Not permitted'
      end
    else
      redirect_to retros_path, alert: 'Not permitted'
    end
  end

  private

  def participant_params
    params.require(:participant).permit(:email)
  end

  def add_participant(email)
    current = @retro.participants.map(&:email).reject { |e| e.starts_with?('guest_') }
    return if current.include? email

    user ||= User.where(email: email).first
    @retro.participants.create({
      retro_id: @retro.id,
      email: email,
      user_id: user ? user[:id] : nil
    })
  end
end
