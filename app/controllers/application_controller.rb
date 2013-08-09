class ApplicationController < Nyara::Controller
  set_default_layout 'layouts/application'
  # helper_method :current_user
  
  def current_user
    @current_user ||= User.where(:_id => session[:user_id]).first
  end
  
  def success(msg)
    flash[:success] = msg
  end
  
  def store_user(user)
    session[:user_id] = user.id
  end
end
