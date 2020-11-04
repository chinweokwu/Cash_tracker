class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[show edit update destroy]
  before_action :logged_in_user

  def index
    @transaction = current_user.transactions.all.order(created_at: :desc)
    @external_transactions = current_user.transactions.where(group_id: nil).order(created_at: :desc)
    @ex_transaction = @transaction.where.not(group_id: nil)
    @external_transaction_sorted = @ex_transaction.includes([:group]).sort_by(&:created_at).reverse
    @total_trans = @ex_transaction.sum(:amount)
    @total_exp = @transaction.sum(:amount)
  end

  def show; end

  def new
    @transaction = current_user.transactions.build
  end

  def edit; end

  def create
    @transaction = current_user.transactions.build(transaction_params)

    respond_to do |format|
      if @transaction.save
        if @transaction.group_id.nil?
          format.html { redirect_to external_path, notice: 'External Transaction was successfully created.' }
          format.json { render :show, status: :created, location: external_path }
        else
          format.html { redirect_to transactions_url, notice: 'Transaction was successfully created.' }
          format.json { render :show, status: :created, location: @transaction }
        end
        format.html { redirect_to transactions_url, notice: 'Transaction was successfully created.' }
        format.json { render :show, status: :created, location: @transaction }
      else
        format.html { render :new }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        if @transaction.group_id.nil?
          format.html { redirect_to external_path, notice: 'External Transaction was successfully updated.' }
          format.json { render :show, status: :created, location: external_path }
        else
          format.html { redirect_to @transaction, notice: 'Transaction was successfully Updated.' }
          format.json { render :show, status: :created, location: @transaction }
        end
        format.html { redirect_to @transaction, notice: 'Transaction was successfully updated.' }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to transactions_url, notice: 'Transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  def transaction_params
    params.require(:transaction).permit(:name, :amount, :user_id, :group_id)
  end
end
