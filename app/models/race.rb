class Race < ApplicationRecord
  has_many :racers
  has_many :rolls

  def last_roll
    self.rolls.last
  end
end
