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

  private
    # Set Bill
    def set_bill
      @bill = Bill.find_by(id: params[:id])
    end

    def bill_params
      params.require(:bill).permit(:id, :client_id)
    end

end
