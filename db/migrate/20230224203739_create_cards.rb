class CreateCards < ActiveRecord::Migration[7.0]
  def change
    create_table :cards do |t|
      t.string :front
      t.text :back
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :cards, [:user_id, :created_at]
  end
end
