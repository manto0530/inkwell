module Inkwell
  module AsFavoritable
    extend ActiveSupport::Concern

    included do
      attr_accessor :favorited
      def favorited?; !!favorited; end

      has_many :favorited_items, class_name: 'Inkwell::FavoritedItem', as: :favorited, dependent: :delete_all

      def favorited_by(page: nil, per_page: nil, order: 'created_at DESC')
        result = favorited_items.includes(:favoriting).order(order)
        result = result.page(page).per(per_page || favorited_by_per_page) if page
        result.map(&:favoriting)
      end

      def favorited_by_per_page
        10
      end
    end
  end
end