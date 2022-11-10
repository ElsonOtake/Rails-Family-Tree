class CreatePairs < ActiveRecord::Migration[7.0]
  def change
    create_table :pairs do |t|
      t.date :marriage
      t.date :separation
      t.string :local
      t.integer :leaf1_id, null: false
      t.integer :leaf2_id, null: false

      t.timestamps
    end
    add_foreign_key :pairs, :leafs, column: :leaf1_id
    add_foreign_key :pairs, :leafs, column: :leaf2_id
  end
end
