class CashTransactionsController < ApplicationController
  before_action :set_cash_transaction

  respond_to :json

  # GET /cash_transactions
  def index
    @cash_transactions = CashTransaction.all
    respond_with @cash_transactions
  end

  # GET /cash_transactions/:id
  def show
    respond_with @cash_transaction
  end

  # POST /cash_transactions
  def create
    @cash_transaction = CashTransaction.new(cash_transaction_params)
    @cash_transaction.save
    respond_with @cash_transaction  
  end

  # POST /cash_transactions
  def update
    @cash_transaction.update(cash_transaction_params)
    respond_with @cash_transaction  
  end

  # Delete
  def destroy
    @cash_transaction.destroy
    respond_to do |format|
      format.html { redirect_to cash_transactions_url, notice: 'Cash transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def today
    @cash_transactions = CashTransaction.where('created_at BETWEEN ? AND ?', DateTime.now.beginning_of_day, DateTime.now.end_of_day).all
    respond_with @cash_transactions
  end

  def from_to
    from = DateTime.new(params[:fy].to_i, params[:fm].to_i, params[:fd].to_i)
    to = DateTime.new(params[:ty].to_i, params[:tm].to_i, params[:td].to_i).end_of_day()
    
    @cash_transactions = CashTransaction.where('created_at BETWEEN ? AND ?', from, to)
    respond_with @cash_transactions
  end

  private
    # Set Sale Transaction
    def set_cash_transaction
      @cash_transaction = CashTransaction.find_by(id: params[:id])
    end

    def cash_transaction_params
      params.require(:cash_transaction).permit(:id, :description, :type_t, :amount)
    end
end
