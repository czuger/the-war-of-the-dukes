class RemoveQrUnicityInPawn < ActiveRecord::Migration[5.1]
  def change
    remove_index :pawns, [:board_id, :q, :r]
		add_index :pawns, [:board_id, :q, :r]
  end
end
