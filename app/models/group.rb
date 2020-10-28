class Group < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, length: { maximum: 20 }
  validates :icon, presence: true
end
