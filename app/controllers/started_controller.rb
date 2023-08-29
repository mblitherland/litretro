class StartedController < ApplicationController
  before_action :authenticate_user!

  def index
    @retro = Retro.find(params[:id])

    @card = Card.new
    @card.color = current_user.last_color
    @user_cards = get_user_cards

    if @retro.user_allowed(current_user.id)
      render @started
    else
      redirect_to '/retros', alert: 'Not permitted'
    end
  end

  def delete_card
    @retro = Retro.find(params[:id])
    @card = Card.find(params[:card_id])

    if @retro.user_allowed(current_user.id) && @card.user_id == current_user.id
      @card.delete
      redirect_to "/started/#{@retro.id}"
    else
      redirect_to '/retros', alert: 'Not permitted'
    end
  end

  def edit_card
    @retro = Retro.find(params[:id])
    @card = Card.find(params[:card_id])
    @card.delete
    @user_cards = get_user_cards

    if @retro.user_allowed(current_user.id)
      render action: :index
    else
      redirect_to '/retros', alert: 'Not permitted'
    end
  end

  private

  def get_user_cards
    user_cards = []
    @retro.columns.each do |column|
      next if column.nil?

      column.cards.each do |card|
        if card.user_id == current_user.id
          user_cards.append(card)
        end
      end
    end
    user_cards
  end
end
