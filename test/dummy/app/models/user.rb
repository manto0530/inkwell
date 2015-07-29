class User < ActiveRecord::Base
  acts_as_blog_owner
  acts_as_community_user
  can_favorite_objects
end
