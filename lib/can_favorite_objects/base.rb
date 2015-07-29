module Inkwell
  module CanFavoriteObjects
    module Base
      def self.included(klass)
        klass.class_eval do
          extend Config
        end
      end
    end

    module Config
      def can_favorite_objects
        include ::Inkwell::CanFavorite
      end
    end
  end
end

::ActiveRecord::Base.send :include, ::Inkwell::CanFavoriteObjects::Base