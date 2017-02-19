class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.belongs_to :nomination, null: false, index: true
      t.belongs_to :user, null: false, index: true

      t.timestamps
    end
    add_column :nominations, :votes_count, :integer
    add_column :teams, :vote_threshold, :integer, default: 1, null: false
    add_index :votes, [:nomination_id, :user_id], unique: true
  end
end
