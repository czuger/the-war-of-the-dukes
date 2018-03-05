class AddFightDataToBoard < ActiveRecord::Migration[5.1]
  def change
    add_column :boards, :fight_data, :string
  end
end
