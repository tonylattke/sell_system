class TagsController < ApplicationController
  before_action :set_tag

  respond_to :json

  # GET /tags
  def index
    @tags = Tag.all
    respond_with @tags
  end

  # GET /tags/:id
  def show
    respond_with @tag
  end

  # GET /tags/search/:data
  def search
    @tags = nil
    tags = Tag.search(params[:data])
    if tags
      @tags = tags
    end
    respond_with @tags
  end

  # POST /tags
  def create
    @tag  = nil
    aux_tag = Tag.find_by(name: tag_params[:name])
    if aux_tag
      respond_with @tag
    else
      @tag = Tag.new(tag_params)
      @tag.save
      respond_with @tag  
    end
  end

  # POST /tags
  def update
    aux_tag = Tag.find_by(name: tag_params[:name])
    if aux_tag && (aux_tag[:id] != tag_params[:id])
      respond_with @tag
    else
      @tag.update(tag_params)
      respond_with @tag  
    end
  end

  # Delete
  def destroy
    @tag.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Set tag
    def set_tag
      @tag = Tag.find_by(id: params[:id])
    end

    def tag_params
      params.require(:tag).permit(:name,:id)
    end

end
