module Inkwell
  class FavoritedItem < ActiveRecord::Base
    belongs_to :favorited, polymorphic: true
    belongs_to :favoriting, polymorphic: true
  end
end
