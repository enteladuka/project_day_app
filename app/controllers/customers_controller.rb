class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user
  #before_action :set_admin_only

  def index
    @customers = Customer.all
  end

  def show
    return not_found if some_condition
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
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
    if @customer.destroy
    flash[:success] = 'Customer was successfully destroyed.'
    redirect_to customers_path
    else
      render 'edit'
    end
  end

  private

    def set_customer
      @customer = Customer.find(params[:id])
    end

    def customer_params
      params.require(:customer).permit(:company, :address, :city, :state, :zip)
    end

    def set_admin_only
      unless current_user.role == "admin"
        flash[:danger] = 'You are not authorized to perform this action'
        redirect_to customers_path
      end
    end

    def logged_in_user
      unless logged_in?
        flash[:info] = "Please log in to continue"
        redirect_to login_url
      end
    end

end
