class CreateDevices < ActiveRecord::Migration[7.2]
  def change
    create_table :devices do |t|
      t.string :serial
      t.string :device_type
      t.integer :status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
