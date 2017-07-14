class AddPresenterToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :presenter, :boolean, default: false
  end
end
