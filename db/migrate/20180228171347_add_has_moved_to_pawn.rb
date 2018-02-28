class AddHasMovedToPawn < ActiveRecord::Migration[5.1]
  def change
    add_column :pawns, :has_moved, :boolean, default: false, null: false
  end
end
