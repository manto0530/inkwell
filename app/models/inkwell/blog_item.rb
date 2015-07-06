module Inkwell
  class BlogItem < ActiveRecord::Base
    belongs_to :blogged_item, polymorphic: true
    belongs_to :blogging_owner, polymorphic: true
  end
end
