class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.text :content, null: false
      t.references :user, null: false
      t.references :task, null: false
      t.timestamps
    end
  end
end
