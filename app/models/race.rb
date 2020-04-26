class Race < ApplicationRecord
  has_many :racers, dependent: :destroy
  has_many :rolls,  dependent: :destroy

  def self.new_race
    self.destroy_all

    race = self.create
    race.update finish_line: 10

    race.racers.create name: 'Alice'
    race.racers.create name: 'Bob'
    race.racers.create name: 'Charlie'
    race.racers.create name: 'Dave'
  end

  def last_roll
    self.rolls.last
  end

  def current_racer
    self.racers.first
  end
end
