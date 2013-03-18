class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.boolean :enable_title
      t.string :phone
      t.string :jabber_id
      t.string :skype_id
      t.string :twitter_id

      t.timestamps
    end
  end
end
