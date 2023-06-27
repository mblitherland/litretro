class CardsController < ApplicationController
  before_action :authenticate_user!

  def create
    puts("*** retro ID: #{params['card']['retro_id']}")
    @retro = Retro.find(params['card'][:retro_id])

    if @retro.user_allowed(current_user.id)
      card = Card.new(card_params)
      card.user_id = current_user.id

      @retro.columns.each do |column|
        if column.name == card.column_desc
          column.cards.append(card)
        end
      end

      redirect_to "/started/#{@retro.id}"
      # render @started
    else
      redirect_to "/retros", status: 403
    end
  end

  private

  def card_params
    params.require(:card).permit(:color, :column_desc, :title)
  end
end
