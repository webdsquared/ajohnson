class Category < ActiveRecord::Base
  attr_accessible :name, :attributes_attributes

  has_many :categorizations
  has_many :posts, through: :categorizations

  validates_presence_of :name
  validates_uniqueness_of :name
end
