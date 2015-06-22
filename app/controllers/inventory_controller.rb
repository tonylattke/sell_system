class InventoryController < ApplicationController
  def index
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

  def delete_product_tags
    product_id = params[:product].to_i

    product_tags = ProductTag.search_by('product_id',product_id)
    for product_tag in product_tags
      product_tag.destroy
    end

    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


end
