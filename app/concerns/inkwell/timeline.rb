module Inkwell
  module Timeline
    extend ActiveSupport::Concern

    included do
      # TODO: add reblogs and favorites and comments count to timelines, blog_item and favoritable

      def process_favorite_feature(result, for_viewer: nil)
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

      def process_reblog_feature(result, for_viewer: nil)
        if Inkwell.reblog_feature && for_viewer && for_viewer.methods.include?(:blog_items)
          items_with_reblogging = result.select{|item| item.methods.include?(:reblogged=)}
          items_with_reblogging.map(&:class).uniq.each do |klass|
            ids = items_with_reblogging.select{|item| item.is_a?(klass)}.map(&:id)
            for_viewer.blog_items.where(blogged_item_id: ids, blogged_item_type: klass.name, is_reblog: true).each do |reblog|
              result.detect{|item| item.id == reblog.blogged_item_id && item.class.name == reblog.blogged_item_type}.reblogged = true
            end
          end
        end
        result
      end
    end
  end
end
