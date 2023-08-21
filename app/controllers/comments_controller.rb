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
          partial: '/discussion/comments',
          locals: { comments: card.comments }
        )
      end
    else
      redirect_to '/retros', alert: 'Not permitted'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:card_id, :comment)
  end
end
