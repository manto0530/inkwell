class Company < ActiveRecord::Base
  acts_as_blog_owner
  acts_as_community_user
  acts_as_favorited_objects_owner

  has_many :products
end
