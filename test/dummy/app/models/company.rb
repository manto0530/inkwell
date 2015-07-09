class Company < ActiveRecord::Base
  acts_as_inkwell_blog_owner
  acts_as_inkwell_community_user

  has_many :products
end
