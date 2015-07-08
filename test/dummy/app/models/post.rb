class Post < ActiveRecord::Base
  belongs_to :user
  acts_as_inkwell_blog_item

  def blog_item_owner
    user
  end
end
