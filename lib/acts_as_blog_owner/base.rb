module Inkwell
  module ActsAsBlogOwner
    module Base
      def self.included(klass)
        klass.class_eval do
          extend Config
        end
      end
    end

    module Config
      def acts_as_blog_owner
        include ::Inkwell::AsBlogOwner
      end
    end
  end
end

::ActiveRecord::Base.send :include, ::Inkwell::ActsAsBlogOwner::Base