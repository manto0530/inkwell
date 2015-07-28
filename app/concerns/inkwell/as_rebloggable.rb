module Inkwell
  module AsRebloggable
    extend ActiveSupport::Concern

    included do
      attr_accessor :reblogged
      def reblogged?; !!reblogged; end
    end
  end
end