class CreateRaces < ActiveRecord::Migration[6.0]
  def change
    create_table :races do |t|
      t.integer :finish_line, null: false, default: 0

      t.timestamps
    end
  end
end
