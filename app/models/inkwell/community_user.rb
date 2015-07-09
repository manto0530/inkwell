module Inkwell
  class CommunitiesUser < ActiveRecord::Base
    belongs_to :community, polymorphic: true
    belongs_to :community_user, polymorphic: true

    # belongs_to Inkwell.community_singular.to_sym
    # belongs_to Inkwell.user_singular.to_sym
    # belongs_to :admins, :foreign_key => "#{Inkwell.user_singular}_id",
    #            class_name: Inkwell.user_class
    # belongs_to :writers, :foreign_key => "#{Inkwell.user_singular}_id",
    #            class_name: Inkwell.user_class
    # belongs_to :muted_users, :foreign_key => "#{Inkwell.user_singular}_id",
    #            class_name: Inkwell.user_class
    # belongs_to :banned_users, :foreign_key => "#{Inkwell.user_singular}_id",
    #            class_name: Inkwell.user_class
    # belongs_to :asked_invitation_users, :foreign_key => "#{Inkwell.user_singular}_id",
    #            class_name: Inkwell.user_class
  end
end