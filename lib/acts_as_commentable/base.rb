module Inkwell
  module ActsAsCommentable
    module Base
      def self.included(klass)
        klass.class_eval do
          extend Config
        end
      end
    end

    module Config
      def acts_as_commentable
        include ::Inkwell::AsCommentable
      end
    end
  end
end

::ActiveRecord::Base.send :include, ::Inkwell::ActsAsCommentable::Base