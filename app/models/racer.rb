class Racer < ApplicationRecord
  def roll roll, speed:
    self.position += (roll.odd? ? 1 : 2)
  end
end
