class SaleTransactionsController < ApplicationController
  before_action :set_sale_transaction

  respond_to :json

  # GET /sale_transactions
  def index
    @sale_transactions = SaleTransaction.all
    respond_with @sale_transactions
  end

  # GET /sale_transactions/:id
  def show
    respond_with @sale_transaction
  end

  # POST /sale_transactions
  def create
    @sale_transaction = SaleTransaction.new(sale_transaction_params)
    @sale_transaction.save
    respond_with @sale_transaction  
  end

  # POST /sale_transactions
  def update
    @sale_transaction.update(sale_transaction_params)
    respond_with @sale_transaction  
  end

  # Delete
  def destroy
    @sale_transaction.destroy
    respond_to do |format|
      format.html { redirect_to sale_transactions_url, notice: 'Sale transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Set Sale Transaction
    def set_sale_transaction
      @sale_transaction = SaleTransaction.find_by(id: params[:id])
    end

    def sale_transaction_params
      params.require(:sale_transaction).permit(:id, :bill_id, :type_t, :amount)
    end

end
