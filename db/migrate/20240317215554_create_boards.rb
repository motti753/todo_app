class CreateBoards < ActiveRecord::Migration[7.1]
  def change
    create_table :boards do |t|
      t.references :user, null: false
      t.timestamps
      t.string :name, null: false
      t.text :description, null: false
    end
  end
end
