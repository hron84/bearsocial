class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.integer :author_id
      t.boolean :published
      t.boolean :deleted
      t.string :slug
      t.integer :parent_post_id
      t.timestamps
    end
  end
end
