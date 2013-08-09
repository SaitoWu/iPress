class UsersController < ApplicationController
  meta '#index'
  get '/' do
    render "users/index"
  end
  
  meta '#show'
  get '/%s' do |login|
    @user = User.where(login: login).first
    if @user.blank?
      render_404
    end
    render "users/show"
  end
end