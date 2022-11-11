class CreateBranches < ActiveRecord::Migration[7.0]
  def change
    create_table :branches do |t|
      t.references :leaf, null: false, foreign_key: true
      t.references :pair, null: false, foreign_key: true

      t.timestamps
    end
  end
end
