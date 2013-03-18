class CreateFriendsUsers < ActiveRecord::Migration
  def change
    create_table :friends_users, :id => false do |t|
      t.integer :friend_id
      t.integer :user_id
    end
  end
end
