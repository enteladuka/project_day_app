class UsersController < ApplicationController
  def index
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
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end

end
