class UpdatePlayers < ActiveRecord::Migration[5.1]
  def change

		add_column :players, :provider, :string
		add_column :players, :uid, :string

		change_column :players, :provider, :string, null: false
		change_column :players, :uid, :string, null: false
		change_column :players, :name, :string, null: false
  end
end
