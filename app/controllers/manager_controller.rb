class ManagerController < ApplicationController
  def index
    
  end

  def sale_transactions_from_to
    @sale_transactions = []
    
    from = DateTime.new(params[:fy].to_i, params[:fm].to_i, params[:fd].to_i)
    to = DateTime.new(params[:ty].to_i, params[:tm].to_i, params[:td].to_i).end_of_day()
    
    bills = Bill.where('created_at BETWEEN ? AND ?', from, to)

    for bill in bills
      @sale_transactions += bill.sale_transactions
    end
  end

  def sale_transactions_today
    @sale_transactions = []
    bills = Bill.where('created_at BETWEEN ? AND ?', DateTime.now.beginning_of_day, DateTime.now.end_of_day).all
    for bill in bills
      @sale_transactions += bill.sale_transactions
    end
  end

end