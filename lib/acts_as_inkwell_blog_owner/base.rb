module Inkwell
  module ActsAsInkwellBlogOwner
    module Base
      def self.included(klass)
        klass.class_eval do
          extend Config
        end
      end
    end

    module Config
      def acts_as_inkwell_blog_owner
        include ::Inkwell::BlogOwner
      end
    end
  end
end

::ActiveRecord::Base.send :include, ::Inkwell::ActsAsInkwellBlogOwner::Base