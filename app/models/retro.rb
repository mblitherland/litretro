class Retro < ApplicationRecord
  validates :description, presence: true
  validates :retro_date, presence: true

  enum :state, {
    setup: 0,
    icebreaker: 1,
    started: 2,
    grouping: 3,
    pointing: 4,
    discussion: 5,
    complete: 6
  }
end
