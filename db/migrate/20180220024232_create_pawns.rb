class CreatePawns < ActiveRecord::Migration[5.1]
  def change
    create_table :pawns do |t|
      t.integer :q, null: false
      t.integer :r, null: false
      t.string :pawn_type, null: false
      t.string :side, null: false
      t.references :board, foreign_key: true, null: false, index: true

      t.timestamps
    end
    add_index :pawns, [ :q, :r ], unique: true
  end
end
