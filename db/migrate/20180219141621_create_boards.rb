class CreateBoards < ActiveRecord::Migration[5.1]
  def change
    create_table :boards do |t|

      t.references :owner, index: true, null: false
      t.references :opponent, null: false
      t.integer :turn, default: 0, null: false

      t.timestamps
    end

    add_foreign_key :boards, :players, column: :owner_id
    add_foreign_key :boards, :players, column: :opponent_id
  end
end

