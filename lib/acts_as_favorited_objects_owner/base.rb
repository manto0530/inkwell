module Inkwell
  module ActsAsFavoritedObjectsOwner
    module Base
      def self.included(klass)
        klass.class_eval do
          extend Config
        end
      end
    end

    module Config
      def acts_as_favorited_objects_owner
        include ::Inkwell::AsFavoritedObjectsOwner
      end
    end
  end
end

::ActiveRecord::Base.send :include, ::Inkwell::ActsAsFavoritedObjectsOwner::Base