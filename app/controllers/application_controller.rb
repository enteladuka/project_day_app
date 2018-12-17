class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  include StatesHelper
  include DisplayErrorHelper

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def index
    flash[:danger] = 'No page found at that address'
    redirect_to root_path
  end

end
