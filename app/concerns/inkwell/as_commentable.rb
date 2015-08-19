module Inkwell
  module AsCommentable
    extend ActiveSupport::Concern

    included do
      include ::Inkwell::Timeline

      has_many :inkwell_comments, as: :commentable, class_name: 'Inkwell::Comment'

      def comments(page: 1, per_page: nil, order: 'created_at DESC', for_viewer: nil)
        result = inkwell_comments.order(order).page(page).per(per_page || comments_per_page)
        result = process_favorite_feature(result, for_viewer: for_viewer)
        process_reblog_feature(result, for_viewer: for_viewer)
      end

      def comments_per_page
        10
      end
    end
  end
end
