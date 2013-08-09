class AccountController < ApplicationController
  meta '#index'
  get '/' do
    render "account/index"
  end

  meta '#new'
  get "/new" do
    @user = User.new
    render "account/new"
  end
  
  meta '#create'
  post "/create" do
    @user = User.new(params)
    if @user.save
      success "Login successed."
      redirect_to "account#login"
    else
      render "account/new"
    end
  end
  
  meta '#login'
  get '/login' do
    @user = User.new
    render "account/login"
  end
  
  meta '#session'
  post '/session' do
    @user = User.where(:email => params[:email]).first
    if @user.blank?
      @user = User.new
      @user.errors.add(:email, "Not found.")
      render "account/login"
      return
    end
    
    if @user.is_valid_password?(params[:password])
      session[:user_id] = @user.id
      success "Login successed."
      redirect_to "welcome#index"      
    else
      render "account/login"
    end
  end
end