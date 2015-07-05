module Inkwell
  class BlogItem < ActiveRecord::Base
    if Inkwell.community_class
      belongs_to Inkwell.community_singular.to_sym, :foreign_key => :owner_id
    end
    belongs_to Inkwell.post_singular.to_sym, :foreign_key => :item_id
  end
end
