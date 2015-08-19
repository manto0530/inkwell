module Inkwell
  module AsBlogItem
    extend ActiveSupport::Concern

    included do
      has_many :blog_items, class_name: 'Inkwell::BlogItem', as: :blogged_item, dependent: :delete_all
      after_create :create_blog_item, if: :need_to_create_blog_item?

      def create_blog_item
        raise(
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

      if Inkwell.reblog_feature
        attr_accessor :reblogged
        def reblogged?; !!reblogged; end
        attr_accessor :reblog
        def reblog?; !!reblog; end

        def reblogged_by(page: nil, per_page: nil, order: 'created_at DESC')
          result = blog_items.where(is_reblog: true).includes(:blogging_owner).order(order)
          result = result.page(page).per(per_page || reblogged_by_per_page) if page
          result.map(&:blogging_owner)
        end

        def reblogged_by_per_page
          10
        end
      end

    end
  end
end
