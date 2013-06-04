class PostsController < ApplicationController
  
  before_filter :authorize, except: [:index, :show, :category]

  def index
  	@posts = Post.all
    @published_posts = Post.search(params[:search])
    @draft_posts = Post.where(published: false)
    @categories = Category.all
    @recent_posts = Post.where(published: true).order("publish_on DESC").limit(4)
    
  end

  def show
  	@post = Post.find(params[:id])
    @post_list = Post.order("publish_on DESC").limit(5).where("published = ?", true)
    @published_posts = Post.where(published: true)
    @recent_posts = Post.where(published: true).order("publish_on DESC").limit(4)
    @categories = Category.all
  end

  def new
  	@post = Post.new
    1.times { @post.categories.build }
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

  def category
    @published_posts = Post.joins(:categories).where("published = 'true' AND categories.id = ?", params[:id] )
    @categories = Category.all
  end
end
