class CreateDawandaUsers < ActiveRecord::Migration
  def change
    create_table :dawanda_users do |t|
      t.string :name
      t.string :url

      t.timestamps null: false
    end
  end
end
