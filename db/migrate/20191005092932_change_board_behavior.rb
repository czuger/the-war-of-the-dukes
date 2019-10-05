class ChangeBoardBehavior < ActiveRecord::Migration[5.1]
  def change
    remove_column :boards, :opponent_id

		add_column :boards, :orf_id, :integer
		add_index :boards, :orf_id
		add_foreign_key :boards, :players, column: :orf_id

		add_column :boards, :wulf_id, :integer
		add_index :boards, :wulf_id
		add_foreign_key :boards, :players, column: :wulf_id
  end
end
