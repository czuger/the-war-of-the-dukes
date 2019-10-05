class AddRemainingMovementToPawn < ActiveRecord::Migration[5.1]
  def change
    remove_column :pawns, :has_moved, :boolean
		add_column :pawns, :remaining_movement, :float, null: false
  end
end
