class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  include StatesHelper
  include DisplayErrorHelper

  def index
    flash[:danger] = 'No page found at that address'
    redirect_to root_path
  end

  def set_admin_only
    role = current_user.role
    unless role == "admin"
      flash[:danger] = 'You are not authorized to perform this action'
    end
  end

end
