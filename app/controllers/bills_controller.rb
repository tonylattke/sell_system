class BillsController < ApplicationController
  before_action :set_bill

  respond_to :json

  # GET /bills
  def index
    @bills = Bill.all
    respond_with @bills
  end

  # GET /bills/:id
  def show
    respond_with @bill
  end

  # POST /bills
  def create
    @bill = Bill.new(bill_params)
    @bill.save
    respond_with @bill  
  end

  # POST /bills
  def update
    @bill.update(bill_params)
    respond_with @bill  
  end

  # Delete
  def destroy
    @bill.destroy
    respond_to do |format|
      format.html { redirect_to bills_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def today
    @bills = Bill.where('created_at BETWEEN ? AND ?', DateTime.now.beginning_of_day, DateTime.now.end_of_day).all
    respond_with @bills
  end

  def from_to
    from = DateTime.new(params[:fy].to_i, params[:fm].to_i, params[:fd].to_i)
    to = DateTime.new(params[:ty].to_i, params[:tm].to_i, params[:td].to_i).end_of_day()
    
    @bills = Bill.where('created_at BETWEEN ? AND ?', from, to)
    respond_with @bills
  end

  private
    # Set Bill
    def set_bill
      @bill = Bill.find_by(id: params[:id])
    end

    def bill_params
      params.require(:bill).permit(:id, :client_id)
    end

end
