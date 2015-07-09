module Inkwell
  module ActsAsInkwellCommunityUser
    module Base
      def self.included(klass)
        klass.class_eval do
          extend Config
        end
      end
    end

    module Config
      def acts_as_inkwell_community_user
        include ::Inkwell::AsCommunityUser
      end
    end
  end
end

::ActiveRecord::Base.send :include, ::Inkwell::ActsAsInkwellCommunityUser::Base