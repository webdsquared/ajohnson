class PagesController < ApplicationController
  def home
  	@published_posts = Post.where(published: true)
  end

  def new_page
  	@published_posts = Post.where(published: true)
  end

  def dashboard
  	@posts = Post.order("created_at DESC")
  	@published_posts = Post.where(published: true)
  	@draft_posts = Post.where(published: false)
  end
end
