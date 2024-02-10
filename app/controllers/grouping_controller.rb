class GroupingController < ApplicationController
  before_action :authenticate_user!

  def index
    @retro = Retro.find(params[:id])

    @parent_cards = []
    @retro.columns.each do |column|
      @parent_cards += column.cards.select { |card| card.parent_card.nil? }
    end

    if @retro.user_allowed(current_user.id)
      render
    else
      redirect_to '/retros', alert: 'Not permitted'
    end
  end
end
