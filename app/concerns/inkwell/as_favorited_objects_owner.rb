module Inkwell
  module AsFavoritedObjectsOwner
    extend ActiveSupport::Concern

    included do
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

      def favorites(page: 1, per_page: nil, order: 'created_at DESC')
        favorited_items.order(order).includes(:favorited).page(page).per(per_page || favorited_items_per_page).map(&:favorited)
      end

      def favorited_items_per_page
        10
      end
    end
  end
end