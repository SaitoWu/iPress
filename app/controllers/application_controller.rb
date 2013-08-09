require_relative "../helpers/app_helper"
class ApplicationController < Nyara::Controller
  set_default_layout 'layouts/application'
  include AppHelper
  
  def current_user
    @current_user ||= User.where(:_id => session[:user_id]).first
  end
  
  def require_user
    if current_user.blank?
      redirect_to 'account#login'
    end
  end
  
  def render_404
    status 404
    send_header rescue nil
    send_string "Page not found."
  end
  
  def success(msg)
    flash[:success] = msg
  end
  
  def save_login(user)
    session[:user_id] = user.id
  end
  
  def clear_login
    session[:user_id] = nil
  end
end
