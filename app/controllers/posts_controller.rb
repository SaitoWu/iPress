class PostsController < ApplicationController
  meta '#index'
  get '/' do
  end
  
  meta '#show'
  get '/%u' do |id|
    @post = Post.find(id)
    render "posts/show"
  end
  
  meta '#new'
  get '/new' do
    @post = Post.new
    render "posts/new"
  end
  
  meta '#create'
  post '/create' do
    @post = Post.new(params[:post])
    @post.user_id = current_user.id
    if @post.save
      success "Post created."
      redirect_to 'posts#show', @post.id
    else
      render "posts/new"
    end
  end
  
  meta '#edit'
  get '/%u/edit' do |id|
    @post = Post.find(id)
    render 'posts/edit'
  end
  
  meta '#update'
  post '/%u/update' do |id|
    @post = Post.find(id)
    if @post.update_attributes(params[:post])
      success "Post updated."
      redirect_to 'posts#show', @post.id
    else
      render "posts/edit"
    end
  end
end