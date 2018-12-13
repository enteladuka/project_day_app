class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def index
    flash[:danger] = 'No page found at that address'
    redirect_to root_path
  end
  
end
