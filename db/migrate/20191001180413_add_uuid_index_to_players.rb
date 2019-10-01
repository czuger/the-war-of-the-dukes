class AddUuidIndexToPlayers < ActiveRecord::Migration[5.1]
  def change
    add_index :players, :uid, unique: true
  end
end
