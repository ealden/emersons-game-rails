class AddRankToRacers < ActiveRecord::Migration[6.0]
  def change
    change_table :racers do |t|
      t.integer :rank
    end
  end
end
