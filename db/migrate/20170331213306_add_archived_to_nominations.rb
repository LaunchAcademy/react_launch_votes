class AddArchivedToNominations < ActiveRecord::Migration[5.0]
  def change
    add_column :nominations, :archived, :boolean, default: false
  end
end
