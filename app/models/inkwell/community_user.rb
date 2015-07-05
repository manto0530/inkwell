module Inkwell
  if ::Inkwell::Engine::config.respond_to?('community_table')
    class CommunityUser < ActiveRecord::Base
      belongs_to ::Inkwell::Engine::config.community_table.to_s.singularize.to_sym
      belongs_to ::Inkwell::Engine::config.user_table.to_s.singularize.to_sym
      belongs_to :admins, :foreign_key => "#{::Inkwell::Engine::config.user_table.to_s.singularize}_id",
                 class_name: ::Inkwell::Engine::config.user_table.to_s.singularize.capitalize
      belongs_to :writers, :foreign_key => "#{::Inkwell::Engine::config.user_table.to_s.singularize}_id",
                 class_name: ::Inkwell::Engine::config.user_table.to_s.singularize.capitalize
      belongs_to :muted_users, :foreign_key => "#{::Inkwell::Engine::config.user_table.to_s.singularize}_id",
                 class_name: ::Inkwell::Engine::config.user_table.to_s.singularize.capitalize
      belongs_to :banned_users, :foreign_key => "#{::Inkwell::Engine::config.user_table.to_s.singularize}_id",
                 class_name: ::Inkwell::Engine::config.user_table.to_s.singularize.capitalize
      belongs_to :asked_invitation_users, :foreign_key => "#{::Inkwell::Engine::config.user_table.to_s.singularize}_id",
                 class_name: ::Inkwell::Engine::config.user_table.to_s.singularize.capitalize
    end
  end
end