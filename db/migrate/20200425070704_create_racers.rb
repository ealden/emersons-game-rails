class CreateRacers < ActiveRecord::Migration[6.0]
  def change
    create_table :racers do |t|
      t.string :name,       null: false, limit: 255
      t.integer :position,  null: false, default: 0
      t.integer :damage,    null: false, default: 0

      t.timestamps
    end
  end
end
