class BillArticlesController < ApplicationController
  before_action :set_bill_article

  respond_to :json

  # GET /bill_articles
  def index
    @bill_articles = BillArticle.all
    respond_with @bill_articles
  end

  # GET /bill_articles/:id
  def show
    respond_with @bill_article
  end

  # POST /bill_articles
  def create
    @bill_article = BillArticle.new(bill_article_params)
    @bill_article.save
    respond_with @bill_article  
  end

  # POST /bill_articles
  def update
    @bill_article.update(bill_article_params)
    respond_with @bill_article  
  end

  # Delete
  def destroy
    @bill_article.destroy
    respond_to do |format|
      format.html { redirect_to bill_articles_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Set BillArticle
    def set_bill_article
      @bill_article = BillArticle.find_by(id: params[:id])
    end

    def bill_article_params
      params.require(:bill_article).permit(:id, :bill_id, :price_id, :amount)
    end
end
