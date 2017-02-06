class CreateNominations < ActiveRecord::Migration[5.0]
  def change
    create_table :nominations do |t|
      t.string :body, null: false
      t.belongs_to :nominator, null: false
      t.belongs_to :nominee, null: false

      t.timestamps
    end
  end
end
