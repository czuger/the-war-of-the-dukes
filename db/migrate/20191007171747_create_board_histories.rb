class CreateBoardHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :board_histories do |t|
      t.references :board, foreign_key: true, index: true, null: false

      t.integer :turn, limit: 1, null: false
      t.integer :movements_increments, null: false, default: 1

      t.jsonb :pawns_positions, null: false

      t.timestamps
		end

		# Way to auto increment a field other than PK in PG
		# execute <<-SQL
     # CREATE SEQUENCE board_histories_movements_increments_seq START 1;
     # ALTER SEQUENCE board_histories_movements_increments_seq OWNED BY board_histories.movements_increments;
     # ALTER TABLE board_histories ALTER COLUMN movements_increments SET DEFAULT nextval('board_histories_movements_increments_seq');
		# SQL

  end
end
