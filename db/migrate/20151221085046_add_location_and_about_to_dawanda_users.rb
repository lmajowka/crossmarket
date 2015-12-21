class AddLocationAndAboutToDawandaUsers < ActiveRecord::Migration
  def change
    add_column :dawanda_users, :location, :string
    add_column :dawanda_users, :about, :text
  end
end
