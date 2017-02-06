class CreateTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :teams do |t|
      t.string :name, null: false
      t.integer :launch_pass_id, null: false

      t.timestamps
    end

    create_table :memberships do |t|
      t.belongs_to :team, null: false
      t.belongs_to :user, null: false

      t.timestamps
    end

    add_column :nominations, :team_id, :integer, null: false
    add_index :memberships, [:team_id, :user_id], unique: true
    add_index :teams, :launch_pass_id, unique: true
  end
end
