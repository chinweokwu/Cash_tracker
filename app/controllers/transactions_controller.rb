class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[show edit update destroy]
  before_action :logged_in_user
  # GET /transactions
  # GET /transactions.json
  def index
    @transaction = current_user.transactions.all
    @ex_transaction = @transaction.where.not(group_id: nil)
    @external_transaction_sorted = @ex_transaction.includes([:group]).sort_by(&:created_at).reverse

    @total_trans = @ex_transaction.sum(:amount)
  end

  # GET /transactions/1
  # GET /transactions/1.json
  def show; end

  # GET /transactions/new
  def new
    @transaction = current_user.transactions.build
  end

  # GET /transactions/1/edit
  def edit; end

  # POST /transactions
  # POST /transactions.json
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

  # PATCH/PUT /transactions/1
  # PATCH/PUT /transactions/1.json
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

  # DELETE /transactions/1
  # DELETE /transactions/1.json
  def destroy
    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to transactions_url, notice: 'Transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def transaction_params
    params.require(:transaction).permit(:name, :amount, :user_id, :group_id)
  end
end
