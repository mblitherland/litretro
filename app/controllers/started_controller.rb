class StartedController < ApplicationController
  before_action :authenticate_user!

  def index
    @retro = Retro.find(params[:id])

    @card = Card.new
    @card.color = 'yellow'
    @user_cards = []

    @retro.columns.each do |column|
      next if column.nil?

      column.cards.each do |card|
        if card.user_id == current_user.id
          @user_cards.append(card)
          @card.color = card.color
        end
      end
    end

    if @retro.user_allowed(current_user.id)
      render @started
    else
      redirect_to '/retros', alert: 'Not permitted'
    end
  end
end
