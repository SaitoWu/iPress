class PostsController < ApplicationController
  before '#new','#create','#edit','#update','#delete' do
    require_user
  end
  
  meta '#index'
  get '/' do
    @posts = Post.limit(20)
    render "posts/index"
  end
  
  meta '#show'
  get '/%u' do |id|
    @post = Post.find(id)
    render "posts/show"
  end
  
  meta '#recent'
  get '/recent' do
    @posts = Post.limit(20)
    render "posts/index"
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
    @post = current_user.posts.find(id)
    render 'posts/edit'
  end
  
  meta '#update'
  post '/%u/update' do |id|
    @post = current_user.posts.find(id)
    if @post.update_attributes(params[:post])
      success "Post updated."
      redirect_to 'posts#show', @post.id
    else
      render "posts/edit"
    end
  end
  
  meta '#delete'
  post '/%u/delete' do |id|
    @post = current_user.posts.find(id)
    @post.destroy!
    redirect_to 'posts#index'
  end
end