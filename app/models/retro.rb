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

  def current_participant(user_id)
    participants.each do |participant|
      if participant.user_id == user_id
        return participant
      end
    end
    return nil
  end

  # Do your best to give a reasonable Bootstrap grid value based upon the number
  # of columns for a full width display
  def grid_value
    case columns.count
    when 1
      12
    when 2
      6
    when 3
      4
    when 5..6
      # 5 doesn't go into 12, so treat it the same as 6
      2
    else
      # No good way to deal with a large number of columns in grid, so revert to
      # something I'd consider 'optimal'. The default when 4 columns
      3
    end
  end

  def user_allowed(user_id)
    allowed_users = participants.map(&:user_id).reject(&:nil?)
    allowed_users.append(user_id)
    return allowed_users.include? user_id
  end
end
