class CardsController < ApplicationController
  before_action :authenticate_user!

  def create
    @retro = Retro.find(params['card'][:retro_id])

    if @retro.user_allowed(current_user.id)
      card = Card.new(card_params)
      card.user_id = current_user.id
      card.votes = 0

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

  def vote
    # I'm not really wrapping security around this.
    # Good luck figuring out both a card and participant id
    card = Card.find(params['id'])
    participant = Participant.find(params['participant_id'])
    if participant.votes > 0
      card.votes += 1
      participant.votes -= 1
      card.save
      participant.save

      card.broadcast_replace_to(
        "card_#{card.id}",
        partial: '/cards/votes',
        locals: { votes: card.votes }
      )
    end
    redirect_to "/pointing/#{card.column.retro.id}"
  end

  private

  def card_params
    params.require(:card).permit(:color, :column_desc, :title)
  end
end
