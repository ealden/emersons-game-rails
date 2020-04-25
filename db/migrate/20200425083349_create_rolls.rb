class CreateRolls < ActiveRecord::Migration[6.0]
  def change
    create_table :rolls do |t|
      t.belongs_to :race
      t.belongs_to :racer
      t.integer :position,      null: false
      t.integer :damage,        null: false
      t.string :speed,          null: false
      t.integer :roll,          null: false
      t.integer :move,          null: false
      t.integer :new_position,  null: false
      t.integer :new_damage,    null: false

      t.timestamps
    end
  end
end
