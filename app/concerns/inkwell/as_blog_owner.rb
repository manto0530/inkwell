module Inkwell
  module AsBlogOwner
    extend ActiveSupport::Concern

    included do
      has_many :blog_items, class_name: 'Inkwell::BlogItem', as: :blogging_owner

      def blog(page: 1, per_page: nil, order: 'created_at DESC', for_viewer: nil)
        result = blog_items.order(order).includes(:blogged_item).page(page).per(per_page || blog_items_per_page).map(&:blogged_item)
        if Inkwell.favorite_feature && for_viewer && for_viewer.methods.include?(:favorited_items)
          items_with_favoriting = result.select{|item| item.methods.include?(:favorited=)}
          items_with_favoriting.map(&:class).uniq.each do |klass|
            ids = items_with_favoriting.select{|item| item.is_a?(klass)}.map(&:id)
            for_viewer.favorited_items.where(favorited_id: ids, favorited_type: klass.name).each do |favorite|
              result.detect{|item| item.id == favorite.favorited_id && item.class.name == favorite.favorited_type}.favorited = true
            end
          end
        end
        result
      end

      def blog_items_per_page
        10
      end
    end
  end
end
