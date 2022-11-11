class CreateLeafs < ActiveRecord::Migration[7.0]
  def change
    create_table :leafs do |t|
      t.string :name
      t.string :gender
      t.string :alive
      t.date :birth
      t.date :death
      t.string :description

      t.timestamps
    end
  end
end
