class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :github_id
      t.string :handle
      t.string :image_url
      t.string :name
      t.integer :sign_in_count, default: 0

      t.timestamps
    end
    add_index :users, :github_id, unique: true
    add_index :users, :handle, unique: true
  end
end
