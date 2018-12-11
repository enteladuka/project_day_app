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

  def edit
  end

  def create
    @customer = Customer.new(customer_params)
      if @customer.save
        redirect_to @customer
        flash[:notice]= 'Customer was successfully created.'
      else
        render 'new'
      end
    end
  end

  def update
      if @customer.update(customer_params)
        redirect_to @customer
        flash[:notice] = 'Customer was successfully updated.'
      else
        render 'edit'
      end
    end
  end

  def destroy
    @customer.destroy
    redirect_to customers_url
    flash[:notice] = 'Customer was successfully destroyed.'
    end
  end

  private

    def set_customer
      @customer = Customer.find(params[:id])
    end

    def customer_params
      params.require(:customer).permit(:company, :address, :city, :state, :zip)
    end
end
