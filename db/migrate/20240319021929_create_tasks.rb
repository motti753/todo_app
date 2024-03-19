class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.references :user, null: false
      t.references :board, null: false
      t.timestamps
    end
  end
end
