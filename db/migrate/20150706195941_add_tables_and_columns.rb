class AddTablesAndColumns < ActiveRecord::Migration
  def change
    if Inkwell.blog_feature
      create_table :inkwell_blog_items do |t|
        t.integer :blogged_item_id
        t.string :blogged_item_type
        t.integer :blogging_owner_id
        t.string :blogging_owner_type
        t.datetime :created_at, null: false
        if Inkwell.reblog_feature
          t.boolean :is_reblog, default: false
          t.integer :reblogged_owner_id
          t.string :reblogged_owner_type
        end
      end

      add_index :inkwell_blog_items, [:blogged_item_id, :blogged_item_type], name: :index_blog_items_on_item
      add_index :inkwell_blog_items, [:blogging_owner_id, :blogging_owner_type], name: :index_blog_items_on_owner
      add_index :inkwell_blog_items, [:reblogged_owner_id, :reblogged_owner_type], name: :index_blog_items_on_reblog_owner
    end

    if Inkwell.community_feature
      create_table :inkwell_communities_users do |t|
        t.integer  :community_user_id
        t.string   :community_user_type
        t.integer  :community_id
        t.string   :community_type
        t.integer  :user_access
        t.integer  :admin_level
        t.boolean  :muted,            default: false
        t.boolean  :active,           default: false
        t.boolean  :banned,           default: false
        t.boolean  :asked_invitation, default: false
        t.datetime :created_at,       null: false
      end

      add_index :inkwell_communities_users, [:community_user_id, :community_user_type], name: :index_community_user_on_user
      add_index :inkwell_communities_users, [:community_id, :community_type], name: :index_community_user_on_community
    end

    if Inkwell.favorite_feature
      create_table :inkwell_favorited_items do |t|
        t.integer :favorited_id
        t.string :favorited_type
        t.integer :favoriting_id
        t.string :favoriting_type
        t.datetime :created_at,       null: false
      end

      add_index :inkwell_favorited_items, [:favorited_id, :favorited_type], name: :index_favorited_items_on_item
      add_index :inkwell_favorited_items, [:favoriting_id, :favoriting_type], name: :index_favorited_items_on_user
    end

    if Inkwell.comment_feature
      create_table :inkwell_comments do |t|
        t.integer  :owner_id
        t.string   :owner_type
        t.text     :body
        t.integer  :parent_id, null: false, index: true
        t.integer  :lft, null: false, index: true
        t.integer  :rgt, null: false, index: true
        t.integer  :depth, null: false, default: 0
        t.integer  :children_count, null: false, default: 0
        t.integer  :commentable_id
        t.string   :commentable_type
        t.datetime :created_at, null: false
        t.datetime :updated_at, null: false
      end

      add_index :inkwell_comments, [:owner_id, :owner_type], name: :index_comments_on_owner
    end
  end
end
