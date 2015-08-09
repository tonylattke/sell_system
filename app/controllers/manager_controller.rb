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
    date = DateTime.new(params[:fy].to_i, params[:fm].to_i, params[:fd].to_i)
    
    # Bills
    aux_bills = Bill.where('created_at BETWEEN ? AND ?', date, date.end_of_day())
    @bills = []
    for bill in aux_bills
      @bills.push(consult_bill(bill))
    end
    
    # Cash Transactions
    @cash_transactions = CashTransaction.where('created_at BETWEEN ? AND ?', date, date.end_of_day())

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

    def consult_bill(bill)      
      products = []
      combos = []

      for bill_article in bill.bill_articles
        price = Price.find_by(id: bill_article[:price_id])
        if price.type_option == 'c'
          combo = Combo.find_by(id: price.combo_id)
          aux_combo = {
            'name'  => combo.name,
            'price' => price.value,
            'amount'=> bill_article.amount
          }
          combos.push(aux_combo)
        elsif price.type_option == 'p'
          product = Product.find_by(id: price.product_id)
          aux_product = {
            'name'  => product.name,
            'price' => price.value,
            'amount'=> bill_article.amount
          }
          products.push(aux_product)
        end
      end

      client_name = nil
      if bill.client_id
        client = Client.find_by(id: bill.client_id)
        client_name = client.name
      end
    
      data_exit = {
        'id'          => bill.id,
        'date'        => bill.created_at,
        'client_name' => client_name,
        'products'    => products,
        'combos'      => combos
      }

      return data_exit
      
    end

end