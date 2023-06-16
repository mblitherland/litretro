class Retro < ApplicationRecord
  validates :description, presence: true
  validates :retro_date, presence: true

  belongs_to :user
  has_many :columns, dependent: :destroy
  has_one :icebreaker, dependent: :destroy
  has_many :participants, dependent: :destroy

  enum :state, {
    setup: 0,
    welcome: 1,
    started: 2,
    grouping: 3,
    pointing: 4,
    discussion: 5,
    complete: 6
  }

  def user_allowed(user_id)
    allowed_users = self.participants.map(&:user_id).reject(&:nil?)
    allowed_users.append(self.user_id)
    return allowed_users.include? user_id
  end
end
