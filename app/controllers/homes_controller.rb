class HomesController < ApplicationController
  before_action :logged_in_user
  def external
    user = User.find_by(id: current_user.id)
    @external_transactions = user.transactions.where(group_id: nil).order(created_at: :desc)
    @total_ex_trans = @external_transactions.sum(:amount)
  end

  def friend_transaction
    @users = User.where.not(id: current_user.id)
    @transactions = Transaction.where.not(user_id: current_user.id)
  end
end
