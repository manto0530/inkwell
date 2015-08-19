module Inkwell
  class Comment < ActiveRecord::Base
    validates :commentable, presence: true
    validates :owner, presence: true
    validates :body, presence: true

    belongs_to :owner, polymorphic: true
    belongs_to :commentable, polymorphic: true

    acts_as_nested_set(order_column: :created_at)


    # def comments_count
    #   self.descendants.size
    # end
    #
    # def favorites_count
    #   ::Inkwell::FavoriteItem.where(:item_id => self.id, :item_type => ::Inkwell::Constants::ItemTypes::COMMENT).size
    # end
    #
    # def reblogs_count
    #   ::Inkwell::BlogItem.where(:item_id => self.id, :item_type => ::Inkwell::Constants::ItemTypes::COMMENT, :is_reblog => true).size
    # end
  end
end
