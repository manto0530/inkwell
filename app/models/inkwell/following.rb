module Inkwell
  class Following < ActiveRecord::Base
    belongs_to :following, :foreign_key => :followed_id, class_name: Inkwell.user_class
    belongs_to :follower, :foreign_key => :follower_id, class_name: Inkwell.user_class
  end
end
