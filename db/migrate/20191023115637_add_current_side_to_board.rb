class AddCurrentSideToBoard < ActiveRecord::Migration[5.1]
  def change
    add_column :boards, :current_side, :string, null: false
		add_column :boards, :retreating_pawn, :string, null: false
  end
end
