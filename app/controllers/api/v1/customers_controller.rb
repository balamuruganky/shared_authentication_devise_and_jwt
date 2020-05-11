class Api::V1::CustomersController < ActionController::Base
  before_action :authenticate_user!
  respond_to :json

  # GET /customers.json
  def index
    @customers = current_user.customers.all
    render :json=> {:customers => @customers}, :status => :ok
  end

end
