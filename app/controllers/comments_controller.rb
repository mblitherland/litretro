class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    card = Card.find(params['comment']['card_id'])

    if card.column.retro.state == 'discussion' && card.column.retro.user_allowed(current_user.id)
      params = comment_params
      if !params['comment'].empty?
        comment = Comment.new(params)
        comment.user_id = current_user.id
        card.comments.append(comment)

        card.broadcast_update_to(
          "card_#{card.id}",
          partial: '/discussion/comment_form',
          locals: { card: card, user_id: current_user.id }
        )
      end
    else
      redirect_to '/retros', alert: 'Not permitted'
    end
  end

  def delete
    comment = Comment.find(params[:id])
    card = comment.card
    if comment.card.column.retro.state == 'discussion' && comment.user_id == current_user.id
      card.comments.delete(comment)

      card.broadcast_update_to(
        "card_#{card.id}",
        partial: '/discussion/comment_form',
        locals: { card: card, user_id: current_user.id }
      )
    else
      redirect_to '/retros', alert: 'Not permitted'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:card_id, :comment)
  end
end
