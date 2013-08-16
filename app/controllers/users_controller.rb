class UsersController < ApplicationController
  meta '#index'
  get '/' do
    render 'users/index'
  end
  
  meta '#show'
  get '/%s' do |login|
    @user = User.where(login: login).first
    @posts = @user.posts.limit(20)
    if @user.blank?
      render_404
    end
    render "posts/index"
  end
  
end