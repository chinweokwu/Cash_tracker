class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :group, optional: true
  has_many :external_transactions, through: :transaction
  validates :name, presence: true, length: { maximum: 20 }
  validates :amount, presence: true, numericality: { less_than_or_equal_to: 100_000, greater_than: 1 }

  def friends
    external_transaction = current_user.transactions.where(group_id: nil).order(created_at: :desc)
    external_transaction_sorted = @ex_transaction.includes([:group]).sort_by(&:created_at).reverse
    ids = external_transaction + external_transaction_sorted
    Transaction.where(id: ids)
  end
end
