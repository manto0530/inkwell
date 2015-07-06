class AddTablesAndColumns < ActiveRecord::Migration
  def change
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
end
