class GuestController < ApplicationController
  # Because this controller creates guest accounts we don't want to authenticate_user! here

  def index
    @retros = Retro.where(guest_link: params[:id])

    if @retros.nil?
      redirect_to '/', status: 403
    end
  end
end
