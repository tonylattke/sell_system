class TransactionsBillsController < ApplicationController

  def index
    
  end

  def consult_bill
    bill = Bill.find_by(id: params[:id])
    
    prices = []
    for price_id in bill.bill_articles
      price = Price.find_by(id: price_id)
      prices.push(price)
    end

    @tests = {
      'Tony'   => 'Lattke',
      'Enrique'  => 'Urbaneja'
    }

  end
  
end
