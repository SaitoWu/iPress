class UsersController < ApplicationController
  meta '#index'
  get '/' do
    render "users/index"
  end
  
  # 下面的启用就会导致 /posts/:id 无法访问
  # meta '#show'
  # get '/%u' do |login|
  #   @user = User.where(login: login).first
  #   if @user.blank?
  #     render_404
  #   end
  #   render "users/show"
  # end
end