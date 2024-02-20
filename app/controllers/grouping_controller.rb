class GroupingController < ApplicationController
  before_action :authenticate_user!

  def index
    @retro = Retro.find(params[:id])

    if @retro.user_allowed(current_user.id)
      render
    else
      redirect_to '/retros', alert: 'Not permitted'
    end
  end

  def parent
    parent = Card.find(params[:parent_card])
    child = Card.find(params[:id])
    retro = parent.column.retro
    owner = retro.user_id == current_user.id

    if parent.column.retro != child.column.retro
      # What nonsense is this!
      redirect_to '/retros', alert: "Please don't"
    end

    redirect_to '/retros', alert: 'Error grouping cards' if parent == child

    if owner
      parent.cards.append(child)

      broadcast_groups(retro)
    else
      redirect_to '/retros', alert: 'Not permitted'
    end
  end

  def unparent
    child = Card.find(params[:id])
    retro = child.column.retro
    owner = retro.user_id == current_user.id

    if owner
      child.parent_card = nil
      child.save!

      broadcast_groups(retro)
    else
      redirect_to '/retros', alert: 'Not permitted'
    end
  end

  private

  def broadcast_groups(retro)
    retro.broadcast_update_to(
      "host_group_retro_#{retro.id}",
      target: "host_group_retro_#{retro.id}",
      partial: '/grouping/all_cards',
      locals: { retro: retro, owner: true }
    )
    retro.broadcast_update_to(
      "user_group_retro_#{retro.id}",
      target: "user_group_retro_#{retro.id}",
      partial: '/grouping/all_cards',
      locals: { retro: retro, owner: false }
    )
  end
end
