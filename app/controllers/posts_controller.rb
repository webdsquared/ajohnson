class PostsController < ApplicationController
  
  before_filter :authorize, except: [:index, :show]

  def index
  	@posts = Post.all
    @published_posts = Post.where(published: true)
    @draft_posts = Post.where(published: false)
  end

  def show
  	@post = Post.find(params[:id])
  end

  def new
  	@post = Post.new
  end

  def create
  	@post = Post.new(params[:post])
  	if params['publish']
      @post.published = true
      @post.publish_on = Time.now
      @post.save
      redirect_to posts_path
  	elsif params['save_as_draft']
  	  @post.published = false
      @post.publish_on = nil
      @post.save
      redirect_to posts_path
    elsif
      render 'new'
  	end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if params['publish']
      @post.published = true
      @post.publish_on = Time.now unless @post.publish_on.present?
      @post.update_attributes(params[:post])
      redirect_to posts_path
    elsif params['save_as_draft']
      @post.published = false
      @post.publish_on = nil
      @post.update_attributes(params[:post])
      redirect_to posts_path
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
  end
end
