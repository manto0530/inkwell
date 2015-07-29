module Inkwell
  module AsBlogOwner
    extend ActiveSupport::Concern

    included do
      include ::Inkwell::Timeline

      has_many :blog_items, class_name: 'Inkwell::BlogItem', as: :blogging_owner

      def blog(page: 1, per_page: nil, order: 'created_at DESC', for_viewer: nil)
        result = blog_items.order(order).includes(:blogged_item).page(page).per(per_page || blog_items_per_page).map(&:blogged_item)
        process_favorite_feature(result, for_viewer: for_viewer)
      end

      def blog_items_per_page
        10
      end

      if Inkwell.reblog_feature
        def reblog(obj, from: nil)
          raise(
              "#{self.class.name} tries to reblog #{obj.class.name} object but it is not acts_as_blog_item.
              If it is correct situation add acts_as_blog_item to #{obj.class.name}".squish
          ) unless obj.methods.include?(:blog_item_owner)
          raise "#{self.class.name} can not reblog its own #{obj.class.name.downcase}" if obj.blog_item_owner.try(:==, self)
          blog_items.create!(blogged_item: obj, is_reblog: true, reblogged_owner: from) unless reblog?(obj)
          self
        end

        def reblog?(obj)
          blog_items.exists?(blogged_item: obj)
        end

        def unreblog(obj)
          blog_items.where(blogged_item: obj).destroy_all
          self
        end
      end
    end
  end
end
