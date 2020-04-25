class Race < ApplicationRecord
  has_many :racers
  has_many :rolls

  def last_roll
    self.rolls.last
  end

  def current_racer
    self.racers.first
  end
end
