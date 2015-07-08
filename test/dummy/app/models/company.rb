class Company < ActiveRecord::Base
  acts_as_inkwell_blog_owner
  has_many :products
end
