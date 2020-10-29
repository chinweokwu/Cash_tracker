class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :group, optional: true
  validates :name, presence: true, length: { maximum: 20 }
  validates :amount, presence: true
end
