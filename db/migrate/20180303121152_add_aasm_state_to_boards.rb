class AddAasmStateToBoards < ActiveRecord::Migration[5.1]
  def change
    add_column :boards, :aasm_state, :string
  end
end
