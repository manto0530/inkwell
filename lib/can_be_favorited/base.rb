module Inkwell
  module WithFavoriteFeature
    module Base
      def self.included(klass)
        klass.class_eval do
          extend Config
        end
      end
    end

    module Config
      def can_be_favorited
        include ::Inkwell::AsFavoritable
      end
    end
  end
end

::ActiveRecord::Base.send :include, ::Inkwell::WithFavoriteFeature::Base