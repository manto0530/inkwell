class Product < ActiveRecord::Base
  validates :company_id, presence: true
  belongs_to :company
  acts_as_inkwell_blog_item
end
