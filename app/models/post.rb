class Post < ActiveRecord::Base
  attr_accessible :body, :publish_on, :title, :published

  validates_presence_of :title
end
