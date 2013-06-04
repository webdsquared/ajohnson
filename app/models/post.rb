class Post < ActiveRecord::Base
  attr_accessible :body, :publish_on, :title, :published, :category_ids, :categories_attributes

 	has_many :categorizations
 	has_many :categories, through: :categorizations
 	
 	accepts_nested_attributes_for :categories, :reject_if => lambda { |a| a[:content].blank? }

  validates_presence_of :title
  validates_uniqueness_of :title
  validates_presence_of :body

  def self.search(search)
    if search
  	 where(['title || body LIKE ? AND published = ?', "%#{search}%", true]).order("publish_on DESC")
      #find(:all, :conditions => ['title || body LIKE ?', "%#{search}%"]).where(published: true)
    else
      where(published: true).order("publish_on DESC")
    end
  end

  extend FriendlyId
  friendly_id :title, use: :slugged

end
  


