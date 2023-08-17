class GuestController < ApplicationController
  # Because this controller creates guest accounts we don't want to authenticate_user! here

  def index
    if Rails.configuration.disable_guests
      redirect_to '/', status: 403
      return
    end

    @retro = Retro.where(guest_link: params[:id]).first

    @all_cards = []
    @retro.columns.each do |column|
      @all_cards += column.cards
    end

    if @retro.nil?
      redirect_to '/', status: 403
    else
      render
    end
  end
end
