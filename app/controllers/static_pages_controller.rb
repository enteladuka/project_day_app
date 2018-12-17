class StaticPagesController < ApplicationController
  before_action :logged_in_user

  def home
  end

  def projects
  end

  def tasks
  end
  
private

  def logged_in_user
    unless logged_in?
      flash[:info] = "Please log in to continue"
      redirect_to login_url
    end
  end
end
