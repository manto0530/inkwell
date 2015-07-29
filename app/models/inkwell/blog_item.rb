module Inkwell
  class BlogItem < ActiveRecord::Base
    belongs_to :blogged_item, polymorphic: true
    belongs_to :blogging_owner, polymorphic: true
    if Inkwell.reblog_feature
      belongs_to :reblogged_owner, polymorphic: true
    end
  end
end
