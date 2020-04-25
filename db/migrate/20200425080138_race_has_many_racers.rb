class RaceHasManyRacers < ActiveRecord::Migration[6.0]
  def change
    change_table :racers do |t|
      t.belongs_to :race
    end
  end
end
