class Customization < ApplicationRecord
  include FindCustom

  validates :key, uniqueness: true
end
