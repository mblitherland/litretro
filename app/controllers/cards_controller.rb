class CardsController < ApplicationController
  before_action :authenticate_user!

  def create
    @retro = Retro.find(params['card'][:retro_id])

    if @retro.state == 'started' && @retro.user_allowed(current_user.id)
      params = card_params
      current_user.last_color = params[:color]
      current_user.save
      if !params['title'].empty?
        card = Card.new(params)
        card.user_id = current_user.id
        card.votes = 0

        @retro.columns.each do |column|
          if column.name == card.column_desc
            column.cards.append(card)
          end
        end
      end

      redirect_to "/started/#{@retro.id}"
    else
      redirect_to "/retros", alert: 'Not permitted'
    end
  end

  def vote
    # I'm not really wrapping security around this.
    # Good luck figuring out both a card and participant id
    card = Card.find(params['id'])
    participant = Participant.find(params['participant_id'])
    if card.column.retro.state == "pointing" && participant.votes > 0
      card.votes += 1
      participant.votes -= 1
      card.save
      participant.save

      card.broadcast_update_to(
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
