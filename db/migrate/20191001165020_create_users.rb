class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|

			t.string :provider, null: false
      t.string :uid, index: { unique: true }, null: false
			t.string :name, null: false

      t.timestamps
    end
  end
end
