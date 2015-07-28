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
    end
  end
end
