module SessionsHelper

  def log_in(user) #logs in the given user
    session[:user_id] = user.id
  end

  def current_user?(user)
    user == current_user
  end

  def remember(user) # remembers a user in a persistent session
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] =  user.remember_token
  end

  def current_user #returns the current logged in user if any
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.autheticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def logged_in? #returns true if the user is logged in, false otherwise
   !current_user.nil?
  end

  def forget(user) #forgets a persistent session
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def log_out #logs out the current user
   forget(current_user)
   session.delete(:user_id)
   @current_user = nil
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
