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
  post '/' do
    @post = Post.new(params[:post])
    if @post.save
      success "Post created."
      redirect_to 'posts#show', @post.id
    else
      render "posts/new"
    end
  end
  
  meta '#edit'
  get '/%u/edit' do
    @post = Post.find(id)
    render 'posts/edit'
  end
  
  meta '#update'
  put '/%u' do |id|
    @post = Post.find(id)
  end
end