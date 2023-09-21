class Customization < ApplicationRecord
  validates :key, uniqueness: true
end
