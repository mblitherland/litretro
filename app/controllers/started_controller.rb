class StartedController < ApplicationController
  before_action :authenticate_user!

  def index
    @retro = Retro.find(params[:id])
    user_cards = []
    @retro.columns.each do |column|
      next if column.nil?
      column.cards.each do |card|
        if card.user_id == current_user.id
          user_cards.append(card)
        end
      end
    end
    puts(">>> user cards: #{user_cards}")

    @started = {
      card: Card.new,
      user_cards: user_cards
    }

    if @retro.user_allowed(current_user.id)
      render @started
    else
      redirect_to "/retros", status: 403
    end
  end

  def create
    @retro = Retro.find(params[:id])

    if @retro.user_allowed(current_user.id)
      card = Card.new(card_params)
      card.user_id = current_user.id

      @retro.columns.each do |column|
        if column.name == card.column_desc
          column.cards.append(card)
        end
      end

      redirect_to "/started/#{@retro.id}"
    else
      redirect_to "/retros", status: 403
    end
  end

  private

  def card_params
    params.permit(:color, :column_desc, :title)
  end
end
