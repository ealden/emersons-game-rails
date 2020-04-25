class AddCrashedAndWonToRoll < ActiveRecord::Migration[6.0]
  def change
    change_table :rolls do |t|
      t.boolean :crashed, null: false,  default: false
      t.boolean :won,     null: false,  default: false
    end
  end
end
