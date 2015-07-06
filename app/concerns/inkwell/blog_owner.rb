module Inkwell
  module BlogOwner
    extend ActiveSupport::Concern

    included do
      has_many :blog_items, class_name: 'Inkwell::BlogItem', as: :blogging_owner

      def blog
        blog_items
      end
    end
  end
end
