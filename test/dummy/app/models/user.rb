class User < ActiveRecord::Base
  acts_as_inkwell_blog_owner
  acts_as_inkwell_community_user
end
