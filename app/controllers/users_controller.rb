class UsersController < ApplicationController
before_action :logged_in_user, only: [:index, :edit, :update, :destroy]

  def index
    @users = User.where(activated: true)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to login_path
    else
      render 'new'
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(user_params)
      flash[:success] = "Your new preferences have been saved!"
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def destroy
    if @user = current_user
      User.find(params[:id]).destroy
      redirect_to root_url
    else
      flash[:alert] = "User could not be destroyed"
    end
  end

  private

    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation, :role)
    end

    def logged_in_user
      unless logged_in?
        flash[:info] = "Please log in to continue"
        redirect_to login_url
      end
    end

end
