class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.belongs_to :nomination, null: false, index: true
      t.belongs_to :user, null: false, index: true

      t.timestamps
    end
    add_index :votes, [:nomination_id, :user_id], unique: true
  end
end
