class UsersController < ApplicationController
before_action :logged_in_user, only: [:index, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id]) # how does params retrieve the user ID exactly?
    #debugger use CTRL+D to exit debugger if needed
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      #log_in @user
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
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def destroy
    if @user = current_user
      User.find(params[:id]).destroy
      redirect_to root_url
    else
      #some error
    end
  end

  private

    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end

    def logged_in_user
      unless logged_in?
        # some error
        redirect_to login_url
      end
    end

end
