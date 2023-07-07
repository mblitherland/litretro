class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    card = Card.find(params['comment']['card_id'])
    if card.column.retro.user_allowed(current_user.id)
      comment = Comment.new(comment_params)
      comment.user_id = current_user.id
      card.comments.append(comment)

      card.broadcast_replace_to(
        "discussion_#{card.id}",
        partial: '/discussion/comments',
        locals: { comments: card.comments }
      )

      redirect_to "/discussion/#{card.column.retro.id}"
    else
      redirect_to "/retros", status: 403
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:card_id, :comment)
  end
end
