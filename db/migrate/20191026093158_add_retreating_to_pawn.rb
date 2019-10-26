class AddRetreatingToPawn < ActiveRecord::Migration[5.1]
  def change
    add_column :pawns, :retreating, :boolean, null: false, default: false

    rename_column :boards, :retreating_pawn, :retreating_side
		change_column :boards, :retreating_side, :string, null: true
  end
end
