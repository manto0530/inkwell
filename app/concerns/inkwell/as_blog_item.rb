module Inkwell
  module AsBlogItem
    extend ActiveSupport::Concern

    included do
      has_many :blog_items, class_name: 'Inkwell::BlogItem', as: :blogged_item
      after_create :create_blog_item, if: :need_to_create_blog_item?

      def create_blog_item
        raise(
            Inkwell::Exceptions::Blog::UndefinedBlogItemOwner,
            "#{self.class.name}#blog_item_owner returns #{blog_item_owner.inspect}.
            Blog item owner should be present.
            If blog item should not be created now -
            redefine #{self.class.name}#need_to_create_blog_item? and return false in this case.".squish
        ) unless blog_item_owner
        blog_items.create! blogging_owner: blog_item_owner
      end

      def blog_item_owner
        nil
      end

      def need_to_create_blog_item?
        true
      end
    end
  end
end
