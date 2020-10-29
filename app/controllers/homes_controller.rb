class HomesController < ApplicationController
    before_action :logged_in_user
    def index
    end
    def new    
    end

    def external
        user = User.find_by(id: current_user.id)
        @external_transactions = user.transactions.where(group_id: nil).order(created_at: :desc)
        # @external_total = @external_user_transactions.sum(:amount)
      end
end
