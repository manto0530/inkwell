class AddTablesAndColumns < ActiveRecord::Migration
  def change
    if Inkwell.blog_feature
      create_table :inkwell_blog_items do |t|
        t.integer :blogged_item_id
        t.string :blogged_item_type
        t.integer :blogging_owner_id
        t.string :blogging_owner_type

        t.datetime :created_at
      end

      add_index :inkwell_blog_items, [:blogged_item_id, :blogged_item_type], name: :index_blog_items_on_item
      add_index :inkwell_blog_items, [:blogging_owner_id, :blogging_owner_type], name: :index_blog_items_on_owner
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
        t.datetime :created_at,       null: false
        t.boolean  :active,           default: false
        t.boolean  :banned,           default: false
        t.boolean  :asked_invitation, default: false
      end
    end
  end
end
