class AddLocaleOptionsToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :locale, :string, :limit => 2
    add_column :profiles, :timezone, :string, :limit => 64
    add_column :profiles, :country, :string
    add_column :profiles, :city, :string
  end
end
