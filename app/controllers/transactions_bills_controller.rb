class TransactionsBillsController < ApplicationController

  def index
    
  end

  def consult_bill
    bill = Bill.find_by(id: params[:id])
    
    products = []
    combos = []

    for bill_article in bill.bill_articles
      price = Price.find_by(id: bill_article[:price_id])
      if price.type_option == 'c'
        combo = Combo.find_by(id: price.combo_id)
        aux_combo = {
          'id'    => combo.id,
          'photo' => combo.photo,
          'price' => price.value,
          'amount'=> bill_article.amount
        }
        combos.push(aux_combo)
      elsif price.type_option == 'p'
        product = Product.find_by(id: price.product_id)
        aux_product = {
          'id' => product.id,
          'photo' => product.photo,
          'price' => price.value,
          'amount'=> bill_article.amount
        }
        products.push(aux_product)
      end
    end
  
    @data_exit = {
      'bill_id'   => bill.id,
      'products'  => products,
      'combos'    => combos
    }

    render json: @data_exit

  end
  
end
