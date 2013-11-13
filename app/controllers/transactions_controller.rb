class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]
  
  #Workaround for https://github.com/ryanb/cancan/issues/835
  load_and_authorize_resource except: [:create, :update]

  # # GET /transactions
  def index
    if current_user
      @transaction = current_user.transactions.sort_by &:dropoff_date
    elsif current_company_user
      @transaction = current_company_user.company_profile.transactions.sort_by &:dropoff_date
    else 
      @transaction = Transaction.all.sort_by &:dropoff_date
    end
  end

  # # GET /transactions/1
  # def show
  # end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
    @transaction.locatables.build
    @addresses = Address.joins(:locatables).where(locatables: { owner_type: "User", owner_id: current_user.id })
  end

  def add_vehicle
    @transaction
  end

  # # GET /transactions/1/edit
  # def edit
  # end

  # POST /transactions
  # POST /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to @transaction, notice: 'Transaction was successfully created.' }
        format.json { render action: 'show', status: :created, location: @transaction }
      else
        format.html { render action: 'new' }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactions/1
  # PATCH/PUT /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to @transaction, notice: 'Transaction was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.json
  def destroy
    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to transactions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transaction_params
      params.require(:transaction).permit(:pickup_address, :dropoff_address, :pickup_date, :pickup_time, :dropoff_date, :dropoff_time,
                     :user_id, :company_profile_id, :vehicle_id, :locatables_attributes => [:address_id, :pickup, :transaction_id, :kind])
    end
end
