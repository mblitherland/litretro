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
        @already_participant = current_participant?
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

    if !@retro.nil?
      u = User.create(
        name: params[:name],
        email: "guest_#{Time.now.to_i}#{rand(99)}@example.com",
        guest: true
      )
      u.save(validate: false)
      sign_in(u)

      @retro.participants.create({
        retro_id: params[@retro.id],
        email: current_user.email,
        user_id: current_user.id,
        guest: true
      })
      redirect_to "/guest/#{@retro.guest_link}/join_registered"
    else
      redirect_to '/', status: 403
    end
  end

  def join_registered
    return if disabled?

    @retro = Retro.where(guest_link: params[:id]).first

    if !@retro.nil? && !current_user.nil?
      unless current_participant?
        @retro.participants.create({
          retro_id: params[@retro.id],
          email: current_user.email,
          user_id: current_user.id,
          guest: true
        })
      end
      render 'joined'
    else
      redirect_to '/', status: 403
    end
  end

  private

  def current_participant?
    @retro.participants.map(&:user_id).include? current_user.id
  end

  def disabled?
    if Rails.configuration.disable_guests
      redirect_to '/', status: 403 if Rails.configuration.disable_guests
      return true
    end
    false
  end
end
