class Community < ActiveRecord::Base
  acts_as_community
  acts_as_favorited_objects_owner
end
