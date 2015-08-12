class ManagerController < ApplicationController
  def index
    
  end

  def transactions_from_to
    from = DateTime.new(params[:fy].to_i, params[:fm].to_i, params[:fd].to_i)
    to = DateTime.new(params[:ty].to_i, params[:tm].to_i, params[:td].to_i).end_of_day()
    
    cash_transactions = CashTransaction.where('created_at BETWEEN ? AND ?', from, to)

    @result = {
      'sale_transactions' => sale_transactions_from_to_aux(),
      'cash_transactions' => cash_transactions
    }

    render json: @result
  end

  def transactions_today
    cash_transactions = CashTransaction.where('created_at BETWEEN ? AND ?', DateTime.now.beginning_of_day, DateTime.now.end_of_day).all
    @result = {
      'sale_transactions' => sale_transactions_today_aux(),
      'cash_transactions' => cash_transactions
    }

    render json: @result
  end

  def report    
    # Sale Transactions
    @sale_transactions = sale_transactions_from_to_aux()
    
    # Cash Transactions
    from = DateTime.new(params[:fy].to_i, params[:fm].to_i, params[:fd].to_i)
    to = DateTime.new(params[:ty].to_i, params[:tm].to_i, params[:td].to_i).end_of_day()
    @cash_transactions = CashTransaction.where('created_at BETWEEN ? AND ?', from, to)

    render :layout => 'report', formats: [:pdf]
  end

  private
    def sale_transactions_from_to_aux
      sale_transactions = []
      
      from = DateTime.new(params[:fy].to_i, params[:fm].to_i, params[:fd].to_i)
      to = DateTime.new(params[:ty].to_i, params[:tm].to_i, params[:td].to_i).end_of_day()
      
      bills = Bill.where('created_at BETWEEN ? AND ?', from, to)

      for bill in bills
        sale_transactions += bill.sale_transactions
      end

      return sale_transactions
    end


    def sale_transactions_today_aux
      sale_transactions = []
      bills = Bill.where('created_at BETWEEN ? AND ?', DateTime.now.beginning_of_day, DateTime.now.end_of_day).all
      for bill in bills
        sale_transactions += bill.sale_transactions
      end

      return sale_transactions
    end

end