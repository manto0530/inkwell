module Inkwell
  module ActsAsBlogItem
    module Base
      def self.included(klass)
        klass.class_eval do
          extend Config
        end
      end
    end

    module Config
      def acts_as_blog_item
        include ::Inkwell::AsBlogItem
      end
    end
  end
end

::ActiveRecord::Base.send :include, ::Inkwell::ActsAsBlogItem::Base