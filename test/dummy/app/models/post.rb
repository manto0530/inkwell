class Post < ActiveRecord::Base
  belongs_to :user
  acts_as_blog_item
  can_be_favorited

  def blog_item_owner
    user
  end
end
