class AddSloganToUsers < ActiveRecord::Migration
  def change
    add_column :users, :slogan, :text
  end
end
