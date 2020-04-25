class Roll < ApplicationRecord
  MAX_DAMAGE = 6

  belongs_to :race
  belongs_to :racer

  def crashed?
    new_damage >= MAX_DAMAGE
  end
end
