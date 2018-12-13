class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  def index
    @customers = Customer.all
  end

  def show
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    binding.pry
      if @customer.save
        redirect_to @customer
        flash[:success]= 'Customer was successfully created.'
      else
        render 'new'
      end
  end

  def edit
  end

  def update
    if @customer.update_attributes(customer_params)
      flash[:success] = 'Customer was successfully updated.'
      redirect_to @customer
    else
      render 'edit'
    end
  end

  def destroy
    @customer.destroy
    flash[:success] = 'Customer was successfully destroyed.'
    redirect_to customers_path
  end

  private

    def set_customer
      @customer = Customer.find(params[:id])
    end

    def customer_params
      params.require(:customer).permit(:company, :address, :city, :state, :zip)
    end

end
