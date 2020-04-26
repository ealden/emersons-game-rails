class Roll < ApplicationRecord
  NO_DAMAGE = 0

  belongs_to :race
  belongs_to :racer

  def damaged?
    self.damage.present? and (self.damage > NO_DAMAGE)
  end

  def normal_speed?
    self.speed == :NORMAL.to_s
  end
end
