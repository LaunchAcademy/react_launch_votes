class RemoveLaunchPassIdFromTeams < ActiveRecord::Migration[5.0]
  def up
    remove_index :teams, :launch_pass_id
    remove_column :teams, :launch_pass_id
  end

  def down
    add_column :teams, :launch_pass_id, :integer
    add_index :teams, :launch_pass_id, unique: true
  end
end
