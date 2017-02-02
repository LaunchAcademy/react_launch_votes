class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :github_uid
      t.string :image_url
      t.string :name
      t.integer :sign_in_count, default: 0

      t.timestamps
    end
    add_index :users, :github_uid, unique: true
    add_index :users, :name, unique: true
  end
end
