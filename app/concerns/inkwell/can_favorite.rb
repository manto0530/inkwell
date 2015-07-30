module Inkwell
  module CanFavorite
    extend ActiveSupport::Concern

    included do
      include ::Inkwell::Timeline

      has_many :favorited_items, class_name: 'Inkwell::FavoritedItem', as: :favoriting

      def favorite(obj)
        favorited_items.create!(favorited: obj) unless favorite?(obj)
        self
      end

      def unfavorite(obj)
        favorited_items.where(favorited: obj).destroy_all
        self
      end

      def favorite?(obj)
        favorited_items.where(favorited: obj).exists?
      end

      def favorites(page: 1, per_page: nil, order: 'created_at DESC', for_viewer: nil)
        result = favorited_items.order(order).includes(:favorited).page(page).per(per_page || favorited_items_per_page).map(&:favorited)
        result = process_favorite_feature(result, for_viewer: for_viewer)
        process_reblog_feature(result, for_viewer: for_viewer)
      end

      def favorited_items_per_page
        10
      end
    end
  end
end