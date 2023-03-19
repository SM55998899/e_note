class CreateTips < ActiveRecord::Migration[7.0]
  def change
    create_table :tips do |t|

      t.string      :title, null: false, limit: 255
      t.text        :memo, limit: 1000
      t.references  :list, null: false, foreign_key: true

      t.timestamps
    end
  end
end
