class AddCurrentRankToRace < ActiveRecord::Migration[6.0]
  def change
    change_table :races do |t|
      t.integer :current_rank
    end
  end
end
