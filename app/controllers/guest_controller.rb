class GuestController < ApplicationController
  # Because this controller creates guest accounts we don't want to authenticate_user! here

  def index
    return if disabled?

    @retro = Retro.where(guest_link: params[:id]).first
    @already_participant = false

    if @retro.nil?
      redirect_to '/', status: 403
    else
      unless current_user.nil?
        if @retro.participants.map(&:user_id).include? current_user.id
          @already_participant = true
        end
      end

      @all_cards = []
      @retro.columns.each do |column|
        @all_cards += column.cards
      end

      render
    end
  end

  def join_guest
    return if disabled?

    @retro = Retro.where(guest_link: params[:id]).first

    if !@retro.nil? && !current_user.nil?

      # TODO: Working here

      @retro.participants.create({
        retro_id: params[@retro.id],
        email: current_user.email,
        user_id: current_user.id,
        guest: true
      })
      render 'joined'
    else
      redirect_to '/', status: 403
    end

  end

  def join_registered
    return if disabled?

    @retro = Retro.where(guest_link: params[:id]).first

    if !@retro.nil? && !current_user.nil?
      @retro.participants.create({
        retro_id: params[@retro.id],
        email: current_user.email,
        user_id: current_user.id,
        guest: true
      })
      render 'joined'
    else
      redirect_to '/', status: 403
    end
  end

  private

  def disabled?
    if Rails.configuration.disable_guests
      redirect_to '/', status: 403  if Rails.configuration.disable_guests
      return true
    end
    false
  end
end
