class SellController < ApplicationController
  include ClientHelper

  def index
  end

  def search_articles_by_tag
    @products = []
    tags = Tag.search(params[:data])
    for tag in tags
      product_tags = ProductTag.search_by('tag_id',tag.id)
      for product_tag in product_tags
        product = Product.find_by(id: product_tag.product_id)
        @products.push(product)
      end
    end

    @combos = []
  end

  def generate_sell
    
    # Client
    if params[:client_new]
      @client = client_create(params[:client])
    else
      if params[:client]
        @client = Client.find_by(id: params[:client][:id])
        @client.balance += params[:recharge_amount].to_i
        @client.balance -= params[:use_from_account].to_i
        @client.save
      else
        @client = nil
      end
    end

    # Bill
    if @client
      @bill = Bill.new(:client_id => @client.id)
    else
      @bill = Bill.new()
    end
    @bill.save

    # Bill Articles
    if params[:cart][:combos]
      for combo in params[:cart][:combos]
        aux_combo = Combo.find_by(id: combo[:id])
        aux_amount = combo[:amount].to_i
        if aux_combo.stock_amount - aux_amount >= 0
          
          # Combo info update       
          aux_combo.stock_amount -= aux_amount
          aux_combo.sales_amount += 1
          aux_combo.save
          
          # Create association Bill with article
          aux_price = Price.find_by(id: combo[:prices][0][:id])
          aux_BA = BillArticle.new(:bill_id => @bill.id, :price_id => aux_price.id, :amount => aux_amount)
          aux_BA.save

          # Product info update
          for combo_product in combo[:combo_products]
            aux_product = Product.find_by(id: combo_product[:product_id].to_i) 
            aux_cp_a = combo_product[:product_amount].to_i * aux_amount
            if aux_product.stock_amount - aux_cp_a >= 0
              aux_product.stock_amount -= aux_cp_a
              aux_product.save
            end
          end

        end
      end
    end

    if params[:cart][:products]
      for product in params[:cart][:products]
        aux_product = Product.find_by(id: product[:id])
        aux_amount = product[:amount].to_i
        if aux_product.stock_amount - aux_amount >= 0
          
          # Product info update
          aux_product.stock_amount -= aux_amount
          aux_product.sales_amount += 1
          aux_product.save
          
          # Create association Bill with article
          aux_price = Price.find_by(id: product[:prices][0][:id])
          aux_BA = BillArticle.new(:bill_id => @bill.id, :price_id => aux_price.id, :amount => aux_amount)
          aux_BA.save
        end
      end
    end


  end

end