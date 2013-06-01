class PagesController < ApplicationController
  def home
  	@published_posts = Post.where(published: true)
  end
end
