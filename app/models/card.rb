class Card < ApplicationRecord
  belongs_to :column
  belongs_to :user

  belongs_to :parent, class_name: 'Card'
  has_many :cards, foreign_key: 'parent_card'

  has_many :comments
end
