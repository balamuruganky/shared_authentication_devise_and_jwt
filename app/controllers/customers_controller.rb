class CustomersController < ApplicationController
  before_action :authenticate_user!
  #load_and_authorize_resource
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json

  # GET /customers
  # GET /customers.json
  def index
    @customers = current_user.customers.all
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
    @customers = Customer.find(params[:id])
    respond_with(@customers)
  end

  # GET /customers/new
  def new
    @customer = Customer.new
  end

  # GET /customers/1/edit
  def edit
    @customers = Customer.find(params[:id])
  end

  # POST /customers
  # POST /customers.json
  def create
    @customer = current_user.customers.create(customer_params)
    @customer.assign_attributes(customer_params)
    respond_to do |format|
      if @customer.save
        format.html { redirect_to @customer, notice: 'Customer was successfully created.' }
        format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to @customer, notice: 'Customer was successfully updated.' }
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :edit }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to customers_url, notice: 'Customer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def customer_params
      params.require(:customer).permit(:organisation_name, :address, :city, :state, :postcode, :country, :phone_number)
    end
end