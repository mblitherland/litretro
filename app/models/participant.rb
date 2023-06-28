class Participant < ApplicationRecord
  belongs_to :retro

  after_update_commit lambda {
    broadcast_replace_to "participants_#{id}",
      partial: 'points_remaining',
      locals: { votes_remaining: current_participant.votes }
  }
end
