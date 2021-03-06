class InventoryController < ApplicationController
  def index
  end

  def product_details
    @tags = []

    product_tags = ProductTag.search_by('product_id',params[:product_id])
    
    for product_tag in product_tags
      tag = Tag.find_by(id: product_tag.tag_id)
      @tags.push(tag)
    end

    @providers = []

    product_providers = ProductProvider.search_by('product_id',params[:product_id])  
    
    for product_provider in product_providers
      provider = Provider.find_by(id: product_provider.provider_id)
      @providers.push(provider)
    end

  end

  def combo_details
    @products = []

    combo_products = ComboProduct.search_by('combo_id',params[:combo_id])
    
    for combo_product in combo_products
      product = Product.find_by(id: combo_product.product_id)
      aux_product = {
        'id'     => product.id,
        'name'   => product.name,
        'photo'   => product.photo,
        'amount' => combo_product.product_amount
      }
      @products.push(aux_product)
    end
    render json: @products
  end

  def tags_by_product
    @tags = []

    product_tags = ProductTag.search_by('product_id',params[:product_id])

    for product_tag in product_tags
      tag = Tag.find_by(id: product_tag.tag_id)
      aux_tag = {
        'id'            => tag.id,
        'name'          => tag.name,
        'product_tag_id'=> product_tag.id
      }
      @tags.push(aux_tag)
    end    

    render json: @tags
  end

  def providers_by_product
    @providers = []

    product_providers = ProductProvider.search_by('product_id',params[:product_id])

    for product_provider in product_providers
      provider = Provider.find_by(id: product_provider.provider_id)
      aux_provider = {
        'id'            => provider.id,
        'name'          => provider.name,
        'product_provider_id'=> product_provider.id
      }
      @providers.push(aux_provider)
    end    

    render json: @providers
  end

  def save_product_tags
    product_id = params[:inventory][:product_id]
    @product_tags = []
    
    for tag_name in params[:inventory][:tags]
      # Save Tag
      aux_tag = Tag.find_by(name: tag_name)
      if aux_tag
        tag = aux_tag
      else
        tag = Tag.new(:name => tag_name)
        tag.save
      end
      
      # Save Product with Tag
      aux_product_tags = ProductTag.search(product_id, tag.id)
      if aux_product_tags.length > 0
        product_tag = aux_product_tags[0]
      else
        product_tag = ProductTag.new(:product_id => product_id, :tag_id => tag.id)
        product_tag.save
      end

      @product_tags.push(product_tag)
    end

  end

  def save_product_providers
    product_id = params[:inventory][:product_id]
    @product_providers = []
    
    for provider_name in params[:inventory][:providers]
      # Save Provider
      aux_provider = Provider.find_by(name: provider_name)
      if aux_provider
        provider = aux_provider
      else
        provider = Provider.new(:name => provider_name)
        provider.save
      end
      
      # Save Product with Tag
      aux_product_providers = ProductProvider.search(product_id, provider.id)
      if aux_product_providers.length > 0
        product_provider = aux_product_providers[0]
      else
        product_provider = ProductProvider.new(:product_id => product_id, :provider_id => provider.id)
        product_provider.save
      end

      @product_providers.push(product_provider)
    end

  end

  def add
    providers = Provider.search(params[:provider][:name])
    if providers.length > 0
      provider = providers[0]
    else
      provider = Provider.new(:name => params[:provider][:name])
      provider.save
    end

    bill_number = params[:bill_number]

    price = params[:price]
    if params[:price] == ""
      price = 0
    end

    bill_provider = BillProvider.new(:provider_id => provider.id, :number => bill_number, :price => price)
    bill_provider.save

    for aux_product in params[:products]
      product = Product.find_by(id: aux_product[:id])
      
      add_product_inventory = AddProductInventory.new(:product_id => product.id, :bill_provider_id => bill_provider.id, :amount => aux_product[:amount])
      add_product_inventory.save

      # Product - update stock amount
      product.stock_amount += aux_product[:amount]
      product.save

      # Product - update price
      if product.prices[0].value != aux_product[:new_price]
        aux_price = Price.new(:product_id =>  product.id, :value => aux_product[:new_price], :type_option => "p")
        aux_price.save
      end
      
    end

    @result= []
    render json: @result
  end

  def delete_product_tags
    product_id = params[:product].to_i

    product_tags = ProductTag.search_by('product_id',product_id)
    for product_tag in product_tags
      product_tag.destroy
    end

    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product tags was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def delete_product_providers
    product_id = params[:product].to_i

    product_providers = ProductProvider.search_by('product_id',product_id)
    for product_provider in product_providers
      product_provider.destroy
    end

    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product providers was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def report
    @products = Product.all
    @combos = Combo.all
    render :layout => 'report', formats: [:pdf]
  end

end
