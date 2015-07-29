class Community < ActiveRecord::Base
  acts_as_community
  can_favorite_objects
end
