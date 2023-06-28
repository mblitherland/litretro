class Column < ApplicationRecord
  belongs_to :retro
  has_many :cards, dependent: :destroy
end
