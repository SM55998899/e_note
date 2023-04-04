class CreateContacts < ActiveRecord::Migration[7.0]
  def change
    create_table :contacts do |t|
      t.references :user, null:false, foreign_key: true

      t.string :name, null: false
      t.text :content, null: false
      t.timestamps
    end
  end
end
